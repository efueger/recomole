#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# -*- mode: python -*-
"""
:mod:`recomole.lowell_mapper` -- lowell dao

=============
Lowell mapper
=============

Dao layer for Lowell db
"""
import logging
from psycopg2 import connect, sql
import psycopg2.extras
import re
from collections import defaultdict

logger = logging.getLogger(__name__)


class FilterError(Exception):
    pass


def die(mesg, exception=RuntimeError):
    logger.error(mesg)
    raise exception(mesg)


class Cursor():
    """ postgres cursor """
    def __init__(self, postgres_url):
        self.postgres_url = postgres_url

    def __enter__(self):
        self.conn = connect(self.postgres_url)
        self.cur = self.conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
        return self.cur

    def __exit__(self, type, value, traceback):
        self.cur.close()
        self.conn.close()


class LowellDBMapper():
    """
    Maps entities through the lowell db
    """
    def __init__(self, lowell_db):
        self.lowell_db = lowell_db
        self.supported_filters = ['subject', 'matType', 'languages']

    def pids2works(self, pids):
        """
        returns the works associated with the provided pids

        :param pids:
            List of pids
        """
        works = {}
        with Cursor(self.lowell_db) as cur:
            cur.execute("SELECT pid,workid FROM relations WHERE pid in %(pids)s", {'pids': tuple(pids)})
            for row in cur:
                works[row['pid']] = row['workid']

        self.__check_pids_are_in_works(pids, works)
        return works

    def works2loancounts(self, workids):
        """
        return loancount for specified workids

        :param workids:
            List of workids
        """
        loancounts = {}
        with Cursor(self.lowell_db) as cur:
            cur.execute("SELECT workid,loancount FROM workid_loancount WHERE workid in %(workids)s", {'workids': tuple(workids)})
            for row in cur:
                loancounts[row['workid']] = row['loancount']
        return loancounts

    def works2meta(self, workids):
        """
        Returns metadata for provided workids

        :param workids:
            List of workids
        """
        works = defaultdict(dict)
        with Cursor(self.lowell_db) as cur:
            cur.execute("SELECT workid,creator,title FROM workid_meta WHERE workid in %(workids)s",
                        {'workids': tuple(workids)})

            for row in cur:
                for type_ in ['creator', 'title']:
                    if type_ in row:
                        works[row['workid']][type_] = row[type_]
            return works

    def __check_pids_are_in_works(self, pids, works):
        for pid in pids:
            if pid not in works:
                logger.warning("Could not find work for pid '%s'", pid)

    def work2pid_loancount(self, workids, filters=None):
        """
        Creates a sql statement to find most loaned pid for each workid,
        provided it passes all given filters.

        :param workids:
            list of workids
        :param filters:
            dictionary with filters to apply
            example: {'matType': ['mat'], 'languages': ['dan', 'eng']}
        """

        workids = sql.SQL(', ').join(sql.Literal(n) for n in workids)

        stmt = sql.SQL(re.sub(" +", " ", """SELECT DISTINCT ON (rel.workid) rel.pid, rel.workid, pl.loancount
                              FROM relations AS rel
                              INNER JOIN pid_loancount as pl
                              ON rel.pid = pl.pid
                              INNER JOIN metadata as met
                              ON rel.pid = met.pid
                              WHERE rel.workid IN ({workids})""")).format(workids=workids)

        filters = self.__get_supported_filters(filters)
        if filters:
            stmt += (sql.SQL('\n') +
                     sql.SQL('\n').join([sql.SQL(" AND met.metadata ->> ") + f for f in self.__filter_creator(filters)]))
        stmt += sql.SQL("""\n ORDER BY rel.workid, pl.loancount DESC;""")

        map_ = {}
        with Cursor(self.lowell_db) as cur:
            print(stmt.as_string(cur))
            cur.execute(stmt)
            for row in cur:
                map_[row['workid']] = {'pid': row['pid'], 'loancount': row['loancount']}
        return map_

    def __get_supported_filters(self, filters):
        if filters:
            return {k: v for k, v in filters.items() if k in self.supported_filters}
        return []

    def __filter_creator(self, request):
        """ Creates SQL filter statements from filter request dictionary"""
        def __map_filter(key, value):
            if key in self.supported_filters:
                return sql.SQL("{type} ?| array[{value}]").format(type=sql.Literal(key),
                                                             value=sql.SQL(', ').join([sql.Literal(v) for v in value]))
            else:
                die("Unknown filter '%s'" % key, FilterError)

        return [__map_filter(k, v) for k, v in request.items()]

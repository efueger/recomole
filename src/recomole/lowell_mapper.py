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
from collections import defaultdict, namedtuple

logger = logging.getLogger(__name__)


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
        return list(works.values())

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

    def work2pid_loancount(self, workids):
        """
        Returns the one pid with the highest loancount for each provided workid

        :param workids:
            List of workids
        """
        map_ = {}
        with Cursor(self.lowell_db) as cur:
            cur.execute("""SELECT DISTINCT ON (relations.workid) relations.pid, relations.workid, pid_loancount.loancount
                           FROM pid_loancount
                           INNER JOIN relations ON pid_loancount.pid = relations.pid
                           WHERE relations.workid IN %(workids)s
                           ORDER BY relations.workid, pid_loancount.loancount DESC""", {'workids': tuple(workids)})
            for row in cur:
                map_[row['workid']] = {'pid': row['pid'], 'loancount': row['loancount']}
        return map_

    def __check_pids_are_in_works(self, pids, works):
        for pid in pids:
            if pid not in works:
                logger.warning("Could not find work for pid '%s'", pid)

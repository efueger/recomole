#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# -*- mode: python -*-
"""
:mod:`recomole.content_first_recommender` -- content first recommender

=========================
Content First Recommender
=========================

Recommender based on content first tags

example of usage:

    import os
    from mobus import PostgresReader
    logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.DEBUG)
    reader = PostgresReader(os.environ['RECMOD_URL'], 'content_first_model')
    cfr = ContentFirstRecommender(reader)

    recs, t = cfr(like=["870970-basis:07129505", "foo"], maxresult=5)
    for r in recs:
        print(r)
"""
import datetime
import logging
import requests
from collections import defaultdict, namedtuple

logger = logging.getLogger(__name__)

Recommendation = namedtuple('Recommendation', 'pid value')


def die(mesg, exception=RuntimeError):
    logger.error(mesg)
    raise exception(mesg)


class SpecificationError(Exception):
    pass


class ContentFirstSpecification():
    """
    Specifies acceptected arguments from the content first recommender
    """
    def validate(self, request):
        """
        Validates request
        """
        allowed_keys = {'like': list, 'maxresult': int}
        mandatory_keys = ['like']

        for key, value in request.items():
            if key not in allowed_keys.keys():
                die("Unknown key: '%s'" % key, SpecificationError)
            if type(value) != allowed_keys[key]:
                die("type mismatch: key '%s' should be of type %s" % (key, allowed_keys[key]), SpecificationError)

        for key in mandatory_keys:
            if key not in request:
                die("necessary key '%s' is missing" % key, SpecificationError)


def pid_tags(url):
    """ yields pid, tag tuples """
    resp = requests.get(url)
    if not resp.ok:
        resp.raise_for_status()
    data = resp.json()
    for e in data:
        yield e['pid'], e['selected']


class ContentFirstRecommender():
    """
    Recommender based on loans
    """
    def __init__(self, lowell_db, reader):
        self.name = 'content-first'
        self.specification = ContentFirstSpecification()
        self.reader = reader
        self.lowell_db = lowell_db

    def __call__(self, **kwargs):
        return self.recommend(**kwargs)

    def recommend(self, **kwargs):
        start = datetime.datetime.now()
        logger.debug("%s called with %s", self.name, kwargs)
        maxresult = self.__maxresult(kwargs)
        recommendations, pid2origin = self.__fetch(kwargs['like'], maxresult)
        recommendations = self.__augment(recommendations, pid2origin)

        return recommendations, {'timings': {'total': (datetime.datetime.now() - start).total_seconds() * 1000}}

    def __fetch(self, pids, limit):
        not_fetched = list(pids)
        pidsums = defaultdict(list)
        from_map = defaultdict(list)
        result = self.reader.find(*pids)
        for pid, recs in result:
            del not_fetched[not_fetched.index(pid)]
            for rec, value in recs[1:]:
                rec = rec.decode("utf-8")
                pidsums[rec].append(value)
                from_map[rec].append(pid)

        logger.warning("Could not find the following pid(s) in model: %s", not_fetched)
        pidsums = {k: sum(v) / len(v) for k, v in pidsums.items()}
        return sorted([Recommendation(k, v) for k, v in pidsums.items()], key=lambda x: x[1])[-limit:][::-1], from_map

    def __augment(self, recommendations, pid2origin):
        return [{'pid': pid, 'val': value, 'from': pid2origin[pid]} for pid, value in recommendations]

    @staticmethod
    def __maxresult(kwargs, default=10):
        if 'maxresult' in kwargs:
            return kwargs['maxresult']
        return default

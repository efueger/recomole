#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# -*- mode: python -*-
"""
:mod:`recomole.loans_recommender` -- loans recommender

=================
Loans Recommender
=================

Recommender based on loans

example of usage:

    import os
    from mobus import PostgresReader

    lowell_db = os.environ['LOWELL_URL']
    reader = PostgresReader(os.environ['RECMOD_URL'], 'cosim_model')
    br = LoansRecommender(lowell_db, reader)

    recs, t = br(like=["870970-basis:23266431", "foo"], maxresults=5, creatormax=2)
    for r in recs:
        print(r)
"""
import datetime
import logging
from collections import Counter, defaultdict, namedtuple
from recomole.lowell_mapper import LowellDBMapper

logger = logging.getLogger(__name__)

Recommendation = namedtuple('Recommendation', 'work value')


def die(mesg, exception=RuntimeError):
    logger.error(mesg)
    raise exception(mesg)


class SpecificationError(Exception):
    pass


class LoansSpecification():
    """
    Specifies acceptected arguments from the loans recommender
    """
    def validate(self, request):
        """
        Validates request
        """
        allowed_keys = {'like': list, 'dislike': list, 'ignore': list, 'filters': dict, 'boosters': dict, 'start': int, 'rows': int}
        self.__validate(request, allowed_keys, 'key')

        mandatory_keys = ['like']
        for key in mandatory_keys:
            if key not in request:
                die("mandatory key '%s' is missing" % key, SpecificationError)

        if 'filters' in request:
            allowed_filters = {'authorFlood': int, 'subject': list, 'matType': list, 'language': list}
            self.__validate(request['filters'], allowed_filters, 'filters')

    def __validate(self, dictionary, allowed_keys, name):
        for key, value in dictionary.items():
            if key not in allowed_keys.keys():
                die("Unknown %s: '%s'. known %ss: [%s]" % (name, key, name.rstrip('s'), '|'.join(allowed_keys.keys())),
                    SpecificationError)
            if type(value) != allowed_keys[key]:
                die("type mismatch: %s '%s' should be of type %s" % (name, key, allowed_keys[key]), SpecificationError)


def author_flood_filter(recommendations, work2meta, creatormax):
    """
    Author flood filter
    """
    start = datetime.datetime.now()
    filtered_recs = []
    creator_count = Counter()
    for r in recommendations:
        if r.work in work2meta:
            creator = work2meta[r.work]['creator']
            if not creator or creatormax > creator_count[creator]:
                filtered_recs.append(r)
            creator_count[creator] += 1

    return filtered_recs, datetime.datetime.now() - start


def to_milli(delta):
    return delta.total_seconds() * 1000


class RecommenderError(Exception):
    pass


class LoansRecommender():
    """
    Recommender based on loans
    """
    def __init__(self, lowell_db, reader):
        self.name = 'loan-cosim'
        self.specification = LoansSpecification()
        self.lowell_db = lowell_db
        self.mapper = LowellDBMapper(self.lowell_db)
        self.reader = reader

    def __call__(self, **kwargs):
        return self.recommend(**kwargs)

    def recommend(self, **kwargs):
        start = datetime.datetime.now()
        timings = {}
        logger.debug("%s called with %s", self.name, kwargs)

        kwargs, maxresults = self.__paging(kwargs)

        pid2work, timings['workids'] = self.__workids(kwargs['like'])
        workids = list(pid2work.values())
        if not workids:
            die("Could not find any works for pids %s" % kwargs['like'], exception=RecommenderError)

        num_cand = maxresults * 5
        recommendations, work2origin, timings['fetch'], timings['from-analysis'] = self.__fetch(workids, pid2work, num_cand)

        work2meta, timings['work2meta'] = self.__work2meta([r.work for r in recommendations])

        if 'filters' in kwargs and 'authorFloodFilter' in kwargs['filters'] and kwargs['filters']['authorFlood'] < maxresults:
            recommendations, flood_timing = author_flood_filter(recommendations, work2meta, kwargs['filters']['authorFlood'])
            timings['flood'] = to_milli(flood_timing)

        if 'ignore' in kwargs:
            ignore_map, timings['ignore-work2pid'] = self.__workids(kwargs['ignore'])
            ignore_workids = list(ignore_map.values()) + workids
            recommendations = [r for r in recommendations if r.work not in ignore_workids]

        work2pid, timings['work2pid'] = self.__work2pid([r.work for r in recommendations])
        recommendations, timings['augment'] = self.__augment(recommendations[kwargs['start']:maxresults], work2pid, work2meta, work2origin)

        timings['total'] = to_milli(datetime.datetime.now() - start)
        logger.debug("Returning result %s, %s", recommendations, {'timings': timings})
        return self.rename_keys(recommendations, {'title': 'debug-title', 'creator': 'debug-creator'}), {'timings': timings}

    @staticmethod
    def __paging(kwargs, start=0, rows=10):
        """ add paging info to kwargs if not present"""
        if 'start' not in kwargs:
            kwargs['start'] = start
        if 'rows' not in kwargs:
            kwargs['rows'] = rows
        return kwargs, kwargs['start'] + kwargs['rows']

    def __workids(self, likes):
        """ Fetch workif for pids in likes"""
        start = datetime.datetime.now()
        workids = self.mapper.pids2works(likes)
        return workids, to_milli(datetime.datetime.now() - start)

    def __work2meta(self, works):
        """ fetch metadata for works """
        start = datetime.datetime.now()
        work2meta = self.mapper.works2meta(works)
        return work2meta, to_milli(datetime.datetime.now() - start)

    def __work2pid(self, works):
        start = datetime.datetime.now()
        work2pid = self.mapper.work2pid_loancount(works)
        return work2pid, to_milli(datetime.datetime.now() - start)

    def rename_keys(self, recommendations, keys):
        """ rename keynames in recommendations """
        for rec in recommendations:
            for name, newname in keys.items():
                if name in rec:
                    rec[newname] = rec[name]
                    del rec[name]
        return recommendations

    def __augment(self, recommendations, work2pid, work2meta, work2origin):
        """ augment recommendation entries with data from work2pid, work2meta and work2origin"""
        start = datetime.datetime.now()
        augmented_recommendations = []
        for workid, value in recommendations:
            if workid in work2pid:
                entry = {'debug-work': workid, 'val': value, 'from': work2origin[workid]}
                entry.update(work2pid[workid])
                entry.update(work2meta[workid])
                augmented_recommendations.append(entry)
        return augmented_recommendations, to_milli(datetime.datetime.now() - start)

    def __fetch(self, workids, pid2work, limit):
        """ fetch recommendations for the provided workids """
        work2pid = {w: p for p, w in pid2work.items()}
        start = datetime.datetime.now()
        result = self.reader.find(*workids)
        find_time = to_milli(datetime.datetime.now() - start)

        start = datetime.datetime.now()
        worksums = defaultdict(list)
        from_map = defaultdict(list)
        for work, recs in result:
            for rec, value in recs[1:]:
                rec = rec.decode("utf-8")
                worksums[rec].append(value)
                from_map[rec].append(work2pid[work])
        worksums = {k: sum(v) / len(v) for k, v in worksums.items()}
        recommendations = sorted([Recommendation(k, v) for k, v in worksums.items()], key=lambda x: x[1])[-limit:][::-1]
        return recommendations, from_map, find_time, to_milli(datetime.datetime.now() - start)

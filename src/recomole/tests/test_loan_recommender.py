#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# -*- mode: python -*-
import os
import unittest

from mobus import PostgresReader
from recomole.loans_recommender import LoansRecommender, RecommenderError


TRAVIS = True if 'TRAVIS' in os.environ else False


def make_pid_set(result):
    return set([r['pid'] for r in result])


@unittest.skipIf(not TRAVIS, "Only works on travis")
class TestFilterCreator(unittest.TestCase):

    def setUp(self):
        self.maxDiff = None
        url = 'postgresql://lowell:test@localhost/testing_db'
        reader = PostgresReader(url, 'cosim_model')
        self.recommender = LoansRecommender(url, reader)

    def test_simple_recommenmdation(self):
        expected = {'870970-basis:27925715',
                    '870970-basis:29705119',
                    '870970-basis:28075480',
                    '870970-basis:51268172',
                    '870970-basis:29401691',
                    '870970-basis:23481561'}

        arguments = {'like': ['870970-basis:28634560']}
        recommendations, timings = self.recommender(**arguments)
        self.assertEqual(expected, make_pid_set(recommendations))

    def test_raises_if_only_unknown_pids_are_given(self):
        with self.assertRaises(RecommenderError):
            arguments = {'like': ['unknown:pid']}
            self.recommender(** arguments)

    def test_ignores_unknown_pid_among_known_pids(self):
        expected = {'870970-basis:27925715',
                    '870970-basis:29705119',
                    '870970-basis:28075480',
                    '870970-basis:51268172',
                    '870970-basis:29401691',
                    '870970-basis:23481561'}

        arguments = {'like': ['unknown:pid', '870970-basis:28634560']}
        recommendations, timings = self.recommender(**arguments)
        self.assertEqual(expected, make_pid_set(recommendations))

    # def test_ignore_does_not_return_ignored_pid(self):
    #     expected = {'870970-basis:52932858', '870970-basis:52932319'}

    #     arguments = {'like': ['870970-basis:29401691', '870970-basis:52932319', '870970-basis:52932858'],
    #                  'ignore': ['870970-basis:23481561']}
    #     recommendations, timings = self.recommender(**arguments)
    #     self.assertEqual(expected, make_pid_set(recommendations))

    # def test_paging_rows(self):
    #     expected = {'870970-basis:52932858', '870970-basis:52932319'}
    #     arguments = {'like': ['870970-basis:29401691', '870970-basis:52932319', '870970-basis:52932858'], 'rows': 2}
    #     recommendations, timings = self.recommender(**arguments)
    #     self.assertEqual(expected, make_pid_set(recommendations))

    # def test_paging_start(self):
    #     expected = {'870970-basis:52932319', '870970-basis:23481561'}
    #     arguments = {'like': ['870970-basis:29401691', '870970-basis:52932319', '870970-basis:52932858'], 'start': 1}
    #     recommendations, timings = self.recommender(**arguments)
    #     print(make_pid_set(recommendations))
    #     #self.assertEqual(expected, make_pid_set(recommendations))

    # def test_paging_start_and_rows(self):
    #     expected = {'870970-basis:52932319'}
    #     arguments = {'like': ['870970-basis:29401691', '870970-basis:52932319', '870970-basis:52932858'], 'start': 1, 'rows': 1}
    #     recommendations, timings = self.recommender(**arguments)
    #     print(make_pid_set(recommendations))
    #     # self.assertEqual(expected, make_pid_set(recommendations))


# {'870970-basis:52932858', '870970-basis:23481561'}
# {'870970-basis:52932858'}



# 870970-basis:28075480
# 870970-basis:27925715
# 870970-basis:51268172
# 870970-basis:28511663
# 870970-basis:29705119

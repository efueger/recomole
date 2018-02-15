#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# -*- mode: python -*-
import os
import unittest

from mobus import PostgresReader
from recomole.loans_recommender import LoansRecommender


TRAVIS = True if 'TRAVIS' in os.environ else False


@unittest.skipIf(not TRAVIS, "Only works on travis")
class TestFilterCreator(unittest.TestCase):

    def setUp(self):
        url = 'postgresql://lowell:test@localhost/testing_db'
        reader = PostgresReader(url, 'cosim_model')
        self.recommender = LoansRecommender(url, reader)

    def test_simple_recommenmdation(self):
        expected = [{'from': ['870970-basis:52932319'],
                     'debug-creator': 'Jakob Høgsbro',
                     'loancount': 1,
                     'val': 0.4082482904638631,
                     'debug-title': 'Runeskrift',
                     'pid': '870970-basis:52932858',
                     'debug-work': 'work:12601842'},
                    {'from': ['870970-basis:52932858'],
                     'debug-creator': '',
                     'loancount': 6,
                     'val': 0.4082482904638631,
                     'debug-title': 'Just sing it!',
                     'pid': '870970-basis:52932319',
                     'debug-work': 'work:12601817'},
                    {'from': ['870970-basis:29401691'],
                     'debug-creator': 'Joel Schumacher',
                     'loancount': 164,
                     'val': 0.0025143306182369295,
                     'debug-title': 'Batman forever',
                     'pid': '870970-basis:23481561',
                     'debug-work': 'work:4813157'}]

        arguments = {'like': ['870970-basis:29401691', '870970-basis:52932319', '870970-basis:52932858']}
        recommendations, timings = self.recommender(**arguments)
        self.assertEqual(expected, recommendations)

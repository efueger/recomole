#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# -*- mode: python -*-
import os
from psycopg2 import connect
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

        arguments = {'like': ['870970-basis:29401691', '870970-basis:52932319', '870970-basis:52932858']}
        recommendations, timings = self.recommender(**arguments)
        print(recommendations)
        # conn = connect(self.url)
        # cur = conn.cursor()
        # cur.execute("SELECT * FROM relations")
        # for row in cur:
        #     print("ROW", row)

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

    def test_test(self):
        print("travis", TRAVIS)
        arguments = {'like': ['870970-basis:29401691','870970-basis:29440670']}
        actual = self.recommender(**arguments)
        print(actual)
        # conn = connect(self.url)
        # cur = conn.cursor()
        # cur.execute("SELECT * FROM relations")
        # for row in cur:
        #     print("ROW", row)

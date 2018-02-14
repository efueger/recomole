#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# -*- mode: python -*-
import os
from psycopg2 import connect

import unittest

TRAVIS = True if 'TRAVIS' in os.environ else False


@unittest.skipIf(not TRAVIS, "Only works on travis")
class TestFilterCreator(unittest.TestCase):

    def setUp(self):
        self.url = 'postgresql://lowell:test@localhost/testing_db'

    def test_test(self):
        print("travis", TRAVIS)

        conn = connect(self.url)
        cur = conn.cursor()
        cur.execute("SELECT * FROM relations")
        for row in cur:
            print("ROW", row)

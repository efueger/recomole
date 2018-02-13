#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# -*- mode: python -*-
import unittest
from recomole.loans_recommender import LoansSpecification, SpecificationError


class TestLoanSpecification(unittest.TestCase):

    def setUp(self):
        self.spec = LoansSpecification()

    def test_spec_raises_if_like_arg_is_missing(self):
        with self.assertRaises(SpecificationError):
            self.spec.validate({'dislike': ['foo', 'bar']})

    def test_spec_raises_with_unknown_arg(self):
        with self.assertRaises(SpecificationError):
            self.spec.validate({'unknown': ['foo', 'bar']})

    def test_spec_raises_with_wrong_arg_type(self):
        with self.assertRaises(SpecificationError):
            self.spec.validate({'like': 2})

    def test_spec_accepted_keys(self):
        accepted_keys = {'dislike': [], 'ignore': [], 'filters': {}, 'boosters': {}}

        for k, v in accepted_keys.items():
            request = {'like': ['foo', 'bar']}
            request[k] = v
            self.spec.validate(request)

    def test_known_filter_validates(self):
        self.spec.validate({'like': ['foo', 'bar'], 'filters': {'authorFlood': 2}})

    def test_unknown_filter_raises(self):
        with self.assertRaises(SpecificationError):
            self.spec.validate({'like': ['foo', 'bar'], 'filters': {'unknownFilter': 2}})

    def test_filter_raises_unknown_arg_type(self):
        with self.assertRaises(SpecificationError):
            self.spec.validate({'like': ['foo', 'bar'], 'filters': {'authorFlood': []}})

    # def test_known_booster_validates(self):
    #     self.spec.validate({'like': ['foo', 'bar'], 'boosters': {'authorFlood': 2}})

    # def test_unknown_booster_raises(self):
    #     with self.assertRaises(SpecificationError):
    #         self.spec.validate({'like': ['foo', 'bar'], 'boosters': {'unknownBooster': 2}})

    # def test_booster_raises_unknown_arg_type(self):
    #     with self.assertRaises(SpecificationError):
    #         self.spec.validate({'like': ['foo', 'bar'], 'boosters': {'authorFlood': []}})


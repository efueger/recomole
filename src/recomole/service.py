#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# -*- mode: python -*-
"""
:mod:`recomole.service` -- recommender service

===================
Recommender Service
===================

Recommender service.

The service has the following endpoints:

"""
from datetime import datetime
import json
from jsonschema.exceptions import ValidationError
import logging
import os
import socket
import tornado.web as tw
import tornado.ioloop as ti
from pyutils import JSONFormatter
from pyutils import build_info
from pyutils import Statistics
from pyutils import Stat
from pyutils import StatusHandler
from pyutils import BaseHandler
from pyutils import create_post_examples_from_dir
from pkg_resources import resource_filename

from mobus import PostgresReader
from recomole.bibdk_recommender import BibDKRecommender

logger = logging.getLogger(__name__)

STATS = {'loan-cosim': Statistics(name='loan-cosim-recommender'),
         'content-first': Statistics(name='content-first-recommender')}


class HelpHandler(BaseHandler):
    """ Help Handler """
    def initialize(self, root_name, name):
        self.name = name
        self.path = resource_filename('recomole', 'data/html/%s/help.html' % name)
        example_path = resource_filename('recomole', 'data/examples/%s' % name)
        self.examples = create_post_examples_from_dir('/%s/%s' % (root_name, name), example_path, suffix='.json', title="Examples")

    def get(self):
        with open(self.path) as fh:
            content = fh.read()
            content = content.replace('@EXAMPLE@', self.examples)
            self.write(content)


class MainHandler(BaseHandler):

    def get(self):
        self.write('\n'.join(['<html>',
                              '<h1>Recomole</h1>',
                              '<h3>endpoints</h3>',
                              '<ul>',
                              ' <li><a href="recomole/loan-cosim">loan cosim</a></li>',
                              '</ul>',
                              '<h3>help pages</h3>',
                              '<ul>',
                              ' <li><a href="recomole/loan-cosim/help">loan cosim</a></li>',
                              '</ul>',
                              '</html>']))


class RecommendHandler(BaseHandler):
    """
    RecommendHandler

    Generic recommendhandler designed to recieve requests via post and
    return recommendations
    """
    def initialize(self, recommender, specification, ab_id, info, stat_collector):
        """
        Initializes handler

        :param recommender:
             Recommender (should inherit from cobet.recommender_base.RecommenderBase)
        :param specification:
             openAPI specifiktaion for service
        :param ab_id:
             ab-id to display in status
        :param info:
             information about build
        :param stat_collector:
             Collector used to collect service traffic
        """
        self.recommender = recommender
        self.ab_id = ab_id
        self.specification = specification
        self.info = info
        self.stat_collector = stat_collector
        self.static_header_content = {'build': self.info['build_number'],
                                      'git': self.info['git'],
                                      'version': self.info['version'],
                                      'ab-id': self.ab_id,
                                      'recommender': self.recommender.name}

    def post(self):
        """ Creates and returns recommendations """
        with Stat(self.stat_collector):
            self.__post()

    def __post(self):
        self.set_header("Content-Type", 'application/json; charset="utf-8"')
        start = datetime.now()
        request = self.__get_request()
        logger.debug("raw request %s", request)
        recommendations, extra = self.recommender(**request)
        self.write(json.dumps(self.__make_response(extra['timings'], recommendations, start)))

    def __make_response(self, timings, recommendations, start):
        response = {'responseHeader': self.__make_header(timings, len(recommendations)),
                    'response': recommendations}
        response['responseHeader']['time'] = int(((datetime.now() - start).total_seconds()) * 1000)
        return response

    def __make_header(self, timings, num_found):
        timings = {k: v for k, v in timings.items() if v}
        header = dict(self.static_header_content)
        header['numFound'] = num_found
        if timings:
            header['timings'] = timings
        return header

    def __get_request(self):
        body = self.request.body.decode(encoding='UTF-8')
        logger.debug('{request: %s, body: %s}' % (self.request, body))
        body = json.loads(body)
        self.__validate_request(body)
        return body

    def __validate_request(self, content):
        try:
            self.specification.validate(content)
        except ValidationError as err:
            raise tw.HTTPError(status_code=400, log_message=str(err))


def make_app(root, recommenders, ab_id):
    info = build_info.get_info('recomole')
    handlers = [(r"/%s/%s" % (root, r.name), RecommendHandler, dict(recommender=r,
                                                                    specification=r.specification,
                                                                    ab_id=ab_id,
                                                                    info=info,
                                                                    stat_collector=STATS[r.name])) for r in recommenders]
    handlers += [(r"/%s/loan-cosim/help" % root, HelpHandler, dict(root_name='recomole', name='loan-cosim')),
                 (r"/%s/content-first/help" % root, HelpHandler, dict(root_name='recomole', name='content-first'))]
    handlers.append((r"/%s/status" % root, StatusHandler, dict(ab_id=1, info=info, statistics=STATS.values())))
    handlers.append((r"/%s" % root, MainHandler))
    return tw.Application(handlers)


def main(port, ab_id):

    root = 'recomole'
    db_urls = get_db_urls({'lowell': 'LOWELL_URL', 'recmod': 'RECMOD_URL'})

    recommenders = [BibDKRecommender(db_urls['lowell'], PostgresReader(db_urls['recmod'], 'cosim_model'))]
    app = make_app(root, recommenders, ab_id)
    logger.info("service up at 'http://%s:%s/%s'" % (socket.gethostname(), port, root))
    app.listen(port)
    ti.IOLoop.current().start()


def get_db_urls(key_value_dict):
    vals = {}
    v = None
    try:
        for key, v in key_value_dict.items():
            vals[key] = os.environ[v]
    except KeyError:
        raise RuntimeError('Environment variable %s must be set' % v)
    return vals


def setup_logger(json_formatter=None, level=logging.DEBUG, logfile_name=None):
    global logger
    if not json_formatter:
        json_formatter = JSONFormatter()

    logger = logging.getLogger('')
    ch = logging.StreamHandler()

    if logfile_name:
        ch.setFormatter(logging.Formatter('%(message)s'))
        fh = logging.FileHandler(logfile_name)
        fh.setFormatter(json_formatter)
        fh.setLevel(logging.DEBUG)
        logger.addHandler(fh)
    else:
        ch.setFormatter(json_formatter)

    ch.setLevel(level)
    logger.addHandler(ch)
    logger.setLevel(logging.DEBUG)


def cli():
    """ Commandline interface """
    import argparse

    port = 7371

    parser = argparse.ArgumentParser(description='recommender service')
    parser.add_argument('-a', '--ab-id', dest='ab_id',
                        help="ab id of service. default is 1", default=1)
    parser.add_argument('-l', '--logfile', dest='logfile',
                        help='Name of logfile. Default is recomole.log', default='recomole.log')
    parser.add_argument('-p', '--port', dest='port',
                        help='port to expose service on. Default is %d' % port, default=port)
    parser.add_argument('-v', '--verbose', dest='verbose', action='store_true',
                        help='verbose output')
    args = parser.parse_args()

    structured_formatter = JSONFormatter(tags={'type': 'service', 'port': args.port})
    level = logging.INFO
    if args.verbose:
        level = logging.DEBUG
    setup_logger(structured_formatter, level, logfile_name=args.logfile)

    main(args.port, args.ab_id)

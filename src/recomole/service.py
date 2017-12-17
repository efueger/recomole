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
import logging
import os
import socket
import tornado.web as tw
import tornado.ioloop as ti
from pyutils import JSONFormatter
from pyutils import build_info
from pyutils import Statistics
from pyutils import StatusHandler
from cobet import RecommendHandler
from mobus import PostgresReader
from recomole.bibdk_recommender import BibDKRecommender

logger = logging.getLogger(__name__)

STATS = {'bibdk': Statistics(name='bibdk-recommender')}


def make_app(root, recommenders, ab_id):
    info = build_info.get_info('recomole')
    handlers = [(r"/%s/%s" % (root, r.name), RecommendHandler, dict(recommender=r,
                                                                    specification=r.specification,
                                                                    ab_id=ab_id,
                                                                    info=info,
                                                                    stat_collector=STATS[r.name])) for r in recommenders]
    handlers.append((r"/%s/status" % root, StatusHandler, dict(ab_id=1, info=info, statistics=STATS.values())))

    return tw.Application(handlers)


def main(port, ab_id):

    root = 'recomole'
    db_urls = get_db_urls({'lowell': 'LOWELL_URL', 'recmod': 'RECMOD_URL'})

    recommenders = [BibDKRecommender(db_urls['lowell'],
                                     PostgresReader(db_urls['recmod'], 'cosim_model'))]
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


if __name__ == "__main__":

    logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)
    main(7371, 1)

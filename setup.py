#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# -*- mode: python -*-
import glob
from setuptools import setup, find_packages

## See the following pages for keywords possibilities for setup keywords, etc.
# https://packaging.python.org/
# https://docs.python.org/3/distutils/apiref.html
# https://docs.python.org/3/distutils/setupscript.html

setup(name='recomole',
      version='0.1.0',
      package_dir={'': 'src'},
      packages=find_packages(where='src'),
      description='recommender service',
      scripts=glob.glob('src/bin/*'),
      test_suite='recomole.tests',
      install_requires=['jsonschema', 'psycopg2', 'tornado'],
      include_package_data=True,
      provides=['recomole'],
      maintainer="search",
      maintainer_email="search@dbc.dk",
      zip_safe=False)

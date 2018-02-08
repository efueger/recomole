#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# -*- mode: python -*-
"""
Small created to parse and analyze output from bench run against ortograf

The bench script is located in pytools
example usage:
    bench http://xpdev-p01:7371/recomole/loan-cosim /home/shm/git/pytools/recomole-requests-10.json -r 1000 -m post | python analyze_loan_cosim_bench_run.py
"""
# import matplotlib
# matplotlib.use('agg')
# import seaborn as sns
# import matplotlib.pyplot as pl
# import numpy as np
import pandas as pd
import json
import sys

if __name__ == "__main__":
    timings = []
    for line in sys.stdin:
        sys.stdout.write(line)
        sys.stdout.flush()
        try:
            resp = json.loads(line)
            t = {'time': resp['time']}
            if 'responseHeader' in resp['value']:
                t.update(resp['value']['responseHeader']['timings'])
        except Exception as exp:
            print(exp, line)
        timings.append(t)
    timings = pd.DataFrame(timings)
    pd.set_option('display.width', 1000)
    df = timings.describe(percentiles=[.25, .5, .75, .95])
    count = int(df.loc['count'][0])
    print("=" * 120)
    print("Count", count)
    df = df.drop(['count'])
    print(df)

    # colnames = list(df.columns.values)
    # rownames = list(df.index.values)

    # f, splots = pl.subplots(len(df.columns), 1, figsize=(8, 6), sharex=True)
    # for i in range(len(df.columns)):
    #     name = colnames[i]
    #     values = np.array(df.ix[:, i].tolist())
    #     sortorder = values.argsort().argsort()
    #     pal = sns.color_palette("Greens_d", len(sortorder))
    #     rank = values.argsort()
    #     sns.barplot(x=rownames, y=values, palette=np.array(pal[::-1])[rank], ax=splots[i])
    #     splots[i].set_ylabel("milliseconds")
    #     f.suptitle("Ortograf bench (count=%d)" % count, fontsize=14)
    #     splots[i].set_title(colnames[i])
    #     pl.savefig('plot.png')

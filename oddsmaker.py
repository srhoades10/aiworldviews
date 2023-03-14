""" Read in Scenarios' odds and weights, calculate overall odds from a weighted
    sum of individual events. Sample a range of odds and weights and draw from
    uniform distributions.

    Pr(AGI2043) = sum((sign*odds*weight/sum(weights)))
"""
import json 
import numpy as np
import pandas as pd
with open('odds.json', 'r') as fin:
    odds = json.load(fin)


weightSum = sum([v['weight'] for _,v in odds.items()])
O = sum([v['sign'] * v['odds'] * (v['weight']/weightSum) for _,v in odds.items()]) 
print('Starting Odds: {}%'.format(round(O*100, 3)))

nSamples=100000
lbCoefficient=0.5
ubCoefficient=2 
O = []
for i in range(nSamples):
    sampleOdds = dict()
    for k,v in odds.items():
        sampleOdds[k] = dict()
        sampleOdds[k]['sign'] = v['sign']

        o = v['odds']
        o_ = np.random.uniform(o*lbCoefficient, o*ubCoefficient, 1)
        o_ = max(0,o_)
        o_ = min(100, o_)
        sampleOdds[k]['odds'] = o_ 
        w = v['weight']
        w_ = np.random.uniform(w*lbCoefficient, w*ubCoefficient, 1)
        w_ = max(0,w_)
        w_ = min(1, w_)
        sampleOdds[k]['weight'] = w_

    weightSum = sum([v['weight'] for _,v in sampleOdds.items()])
    O_ = sum([v['sign'] * v['odds'] * (v['weight']/weightSum) for _,v in sampleOdds.items()])
    if O_[0] < 0:
        O_ = 0
    elif O_[0] > 1:
        O_ = 1
    else:
        O_ = O_[0] 

    O.append([i, O_])

df = pd.DataFrame(O)
df.columns = ['i', 'odds']

from scipy import stats
print(stats.describe(df['odds']))

df.to_csv('odds.csv', index=False)
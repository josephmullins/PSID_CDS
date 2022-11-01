# make a vertical state file

import pandas as pd
import numpy as np

D = pd.read_csv('State.csv')

years = range(1968,1998)+range(1999,2016,2)
vv = ['rel','intnum','state']

D.columns = [v+str(y) for y in years for v in vv]

St = pd.DataFrame()
for y in years:
	d = D[['intnum'+str(y),'state'+str(y)]]
	d.columns = ['intnum','state']
	d['year'] = y
	d=d[d.intnum.notnull()]
	St = pd.concat((St,d),0)


St.to_csv('StateVertical.csv')
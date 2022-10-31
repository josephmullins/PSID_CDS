
import pandas as pd
import numpy as np

H = pd.read_csv('Housework.csv')

years = range(1976,1982)+range(1983,1998)+range(1999,2016,2)
cc = ['R','intnum','sp_hswrk','hd_hswrk']
cols = []
for y in years:
	if (y==1976) | (y==1985):
		cols += [x+str(y) for x in ['R','intnum','hd_hswrk','sp_hswrk']]
	else:
		cols += [x+str(y) for x in cc]

H.columns = cols

D = pd.DataFrame()
for y in [1976]+years:
	d = H[['intnum'+str(y),'hd_hswrk'+str(y),'sp_hswrk'+str(y)]]
	d.columns = ['intnum','hd_hswrk','sp_hswrk']
	d['year'] = y
	if y<1995:
		d.hd_hswrk = d.hd_hswrk.replace({98 : np.nan, 99: np.nan})
		d.sp_hswrk = d.sp_hswrk.replace({98 : np.nan, 99: np.nan})
	d.hd_hswrk=d.hd_hswrk.replace({998 : np.nan, 999: np.nan})
	d.sp_hswrk=d.sp_hswrk.replace({998 : np.nan, 999: np.nan})
	D = pd.concat((D,d),0)


D.to_csv('HouseworkClean.csv')

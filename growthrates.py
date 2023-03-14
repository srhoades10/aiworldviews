
def compound_interest_calculator(principal, rate, years=200, periods=1):
    """ Calculate compound interest, annual

    A = P(1 + r/n)**nt


    A = Accrued amount (principal + interest)
    P = Principal amount
    r = Annual nominal interest rate as a decimal
    R = Annual nominal interest rate as a percent
    r = R/100
    n = number of compounding periods per unit of time
    t = time in decimal years; e.g., 6 months is calculated as 0.5 years. Divide your partial year number of months by 12 to get the decimal years.
    I = Interest amount
    ln = natural logarithm, used in formulas below
    """ 

    return principal * (1+rate/periods)**(periods*years)


collect = []
for i in range(1, 120):
    half = compound_interest_calculator(principal=10000, rate=0.5/100, years=i)
    four = compound_interest_calculator(principal=10000, rate=4/100, years=i)
    eight = compound_interest_calculator(principal=10000, rate=6/100, years=i) 
    collect.append([half, four, eight])

import pandas as pd 
import numpy as np 
from matplotlib import pyplot as plt 

df = pd.DataFrame(collect)
df.columns = ['half', 'four', 'six']
df['year'] = list(range(1,120))
dfM = df.melt(id_vars='year')
dfM.to_csv('growths.csv', index=False)
plt.plot(df['year'], df['half'], label = "0.5%")
plt.plot(df['year'], df['four'], label = "4%")
plt.plot(df['year'], df['six'], label = "6%")
plt.legend()
plt.show()
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

data = pd.read_csv('./file.csv')
dat = data['in']
dat = list(dat)
#clk = data['clk']
#clk = list(clk)

time = [i for i in range(0, len(dat))]
clk = [np.sin(i/2) for i in range(0, len(dat))]

plt.plot(time, dat, '-p', markersize=5)
plt.plot(time, clk, '-p', markersize=5)
plt.show()

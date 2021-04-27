
#########################  DEMODULATOR  ########################

# receives modulated analog signal as input and demodulares
# it to get back our digital data

################################################################

# import dependencies
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import os
import helpers


# check if input file exists...
if not os.path.exists('signal.csv'):
    print('error: Input file (signal.csv) not found!!')
    exit()

# get input signal as a pandas dataframe and convert it to python list
modulatedSignal = pd.read_csv('signal.csv', names = [0])
modulatedSignal = list(modulatedSignal[modulatedSignal.columns[0]])


samplingFreq = 50
# time where the signal is defined
mod_time = [i/samplingFreq for i in range(0, len(modulatedSignal))]

high_frequency = 2
low_frequency = 0.5
# referance low and high frequency signals(required for further use)
# simple sine signals with fixed frequency each
refLowFreq = [helpers.signal(i, low_frequency) for i in mod_time]
refHighFreq = [helpers.signal(i, high_frequency) for i in mod_time]


# multiply modulated signal with referance signals
productLow = [ modulatedSignal[i]*refLowFreq[i] for i in range(0, len(modulatedSignal)) ]
productHigh = [ modulatedSignal[i]*refHighFreq[i] for i in range(0, len(modulatedSignal))]


output = []     # list to store demodulated signal
# define time period in which output signal will be defined
outTime = [ i for i in range(0, int(len(modulatedSignal)/samplingFreq)) ]


# where magic happens :)
# for each segment of size sampling frequency(length of a bit), calculate mean 
# of each product signals. The bit is determined by the maximum of the two means
base = 0
while(base < len(modulatedSignal)):
    sumlow = 0
    sumhigh = 0
    for j in range(0, samplingFreq):
        sumlow += productLow[base+j]
        sumhigh += productHigh[base+j]
    output.append(1 if sumhigh > sumlow else 0)
    base += samplingFreq


# print demodulated digital data out...
for i in output:
    print(i)

# time where input modulated signal is defined(for ploting)
time = [i/samplingFreq for i in range(0, len(modulatedSignal))]


# plot the signals...
plt.plot(time, modulatedSignal)     # input modulated signal
plt.plot(outTime, output)           # output digital signal


plt.show()

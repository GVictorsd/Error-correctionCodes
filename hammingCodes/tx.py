########################  MODULATOR  ##############################

# This unit takes in data to be transfered in digital
# form and converts it into modulated analog form...
# Frequency shift keying is the type of Modulation begin done
#
# INPUT: Data in digital form
# PROCESSING: Frequency shift keying(FSK)
# OUTPUT: Modulated data in analog form

####################################################################

# import dependencies
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import os
import helpers


# helpful functions
def signal(n, freq):
    '''
    function defining the frequency modulation
    signal...
    Input: value(n) and frequency(freq)
    Returns: value of sine(n) with frequency(freq) which is
        normalized to oscilate between 0 and 1
    '''
    return 0.5+(np.sin(freq*i))/2


if not os.path.exists('./file.csv'):
    print('error: No file.csv file found!!')
    exit(-1)

# A bit of preprocessing the input file...
#####
''' TODO: need not perform always!!!'''
removeList = [0,1,2,3,4,37,38,39,40,41]
helpers.preprocess('file.csv',removeList)

# import data from file.csv
data = pd.read_csv('./file.csv')


clk = data[data.columns[2]]         # get clock data from the DataFrame
clk = list(clk)                     # and convert to python list
data = data[data.columns[0]]        # get transmitted data
data = list(data)


# define time interval where data is defined
time = [i for i in range(0, len(data))]

samplingFreq = 50   # sampling frequency for modulated analog output
# sampled time and clock
mod_time = [ i/samplingFreq  for i in range(0, samplingFreq*len(data)) ]
mod_clk = [ clk[int(i/samplingFreq)] for i in range(0, samplingFreq*len(clk)) ]


freq = []   # list to hold modulated signal
high_frequency = 10
low_frequency = 5
for i in mod_time:
    if(data[int(i)] >= 0.5):
        freq.append(signal(i, high_frequency))
    else:
        freq.append(signal(i, low_frequency))


# Plot the signals...
#plt.plot(time, dat, '-p', markersize=5)
#plt.plot(time, clk)
plt.plot(mod_time, mod_clk)     #clock signal
plt.plot(time, data)            #data signal
plt.plot(mod_time, freq)        # modulated signal
plt.show()


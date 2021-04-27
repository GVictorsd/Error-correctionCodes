
###################  MODULATOR  ########################

# This unit takes in data to be transfered in digital
# form and converts it into modulated analog form...
# Frequency shift keying is the type of Modulation begin done
#
# INPUT: Data in digital form
# PROCESSING: Frequency shift keying(FSK)
# OUTPUT: Modulated data in analog form

########################################################

# import dependencies
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import os
import helpers


# check if input exists...
if not os.path.exists('./file.csv'):
    print('error: No raw.csv file found!!')
    exit(-1)

# A bit of preprocessing input file...
# just a simple formating, no big deal :)
removeList = [0,1,2,3,4,37,38,39,40,41]
helpers.preprocess('raw.csv','file.csv',removeList)

# import data from file.csv as pandas dataframe
data = pd.read_csv('./file.csv', names = [0,1,2])


clk = data[data.columns[2]]         # get clock data from the DataFrame
clk = list(clk)                     # and convert to python list
data = data[data.columns[0]]        # get transmitted data
data = list(data)


# define time interval where data is defined
time = [i for i in range(0, len(data))]

samplingFreq = 50   # sampling frequency for modulated analog output
# sampled time and clock...
mod_time = [ i/samplingFreq  for i in range(0, samplingFreq*len(data)) ]
mod_clk = [ clk[int(i/samplingFreq)] for i in range(0, samplingFreq*len(clk)) ]


freq = []   # list to hold modulated signal
high_frequency = 2
low_frequency = 0.5


# define the actual modulated signal...
for i in mod_time:
    if(data[int(i)] >= 0.5):
        # if value of input signal is greater than threshold
        # use high frequency signal(it's digital 1)
        freq.append(helpers.signal(i, high_frequency))
    else:
        # else use low frequency signal(it's digital 0)
        freq.append(helpers.signal(i, low_frequency))


# output the modulated signal to a file for receiver section
outputfile = open('signal.csv', 'w')
for i in freq:
    outputfile.write(i.astype('str') + '\n')
outputfile.close()

# Plot the signals...
plt.plot(mod_time, mod_clk)     #clock signal
plt.plot(time, data)            #data signal
plt.plot(mod_time, freq)        # modulated signal


plt.show()

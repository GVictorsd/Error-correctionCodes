
#################### SOME USEFUL FUNCTIONS ###################

# definations of some useful functions used in the 
# main programs

##############################################################

import os
import numpy as np

def preprocess(inputfile, outputfile, skiplist):
    '''
    function to remove the unwanted lines given out by the
    verilog module...
    just to clean up the input file to get perfect csv file...
    nothing fancy :)
    '''
    
    # check if file exists
    if not os.path.exists(inputfile):
        return None

    tempfile = 'temp'
    counter = 0
    isSkipped = False

    infile = open(inputfile, 'r')
    dumfile = open(tempfile, 'w')
    
    for line in infile:
        if counter not in skiplist:
            dumfile.write(line)
        else:
            isSkipped = True
        counter += 1

    if isSkipped:
        os.rename(tempfile, outputfile)
    else:
        os.remove(tempfile)

    infile.close()
    dumfile.close()

    return 0

def signal(n, freq):
    '''
    Input: value(n) and frequency(freq)
    Returns: value of sine(n) with frequency(freq)
    '''
    return (np.sin(2*np.pi*freq*n))



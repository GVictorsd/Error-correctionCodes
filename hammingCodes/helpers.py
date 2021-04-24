import os

def preprocess(inputfile, skiplist):
    if not os.path.exists(inputfile):
        return -1

    tempfile = 'temp'
    counter = 0
    isSkipped = False

    infile = open(inputfile, 'r')
    dumfile = open(tempfile, 'w')
    
    dumfile.write('0, 1, 2')
    for line in infile:
        if counter not in skiplist:
            dumfile.write(line)
        else:
            isSkipped = True
        counter += 1

    if isSkipped:
        os.remove(inputfile)
        os.rename(tempfile, inputfile)
    else:
        os.remove(tempfile)

    infile.close()
    dumfile.close()

    return 0

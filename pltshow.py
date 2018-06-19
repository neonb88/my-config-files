import sys
import matplotlib.pyplot as plt
import imageio as ii
import numpy as np

def pltshow(np_arr):
    '''
        simple show array func
    '''
    plt.imshow(np_arr); plt.show(); plt.close()

def np_arr_from_filename(filename):
    return np.asarray(ii.imread(filename))

if __name__=='__main__':
    '''
        usage: p35 pltshow.py filename.png
    '''
    usage = '      usage: p35 pltshow.py filename.png'
    print(usage)
    pltshow(
        np_arr_from_filename(
            sys.argv[1]))

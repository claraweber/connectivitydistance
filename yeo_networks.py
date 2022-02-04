# global imports
import pandas as pd
import numpy as np
import os
import scipy.io as sio

# count number of vertices in each yeo network (needed to sort later)
unique, counts = np.unique(yeo, return_counts=True)
addup = [0]
sum = 0
for i, count in enumerate(counts):
    addup.append(count+sum)
    sum +=count
print(addup)

def organizeyeo(inmat):
    yeo = sio.loadmat('/yeo_fsaverage5.mat')
    yeo = yeo['yeo']
    yeo = np.array(yeo, dtype='f')
    yeo = yeo[0]
    yeo = yeo[:len(inmat)]
    new = np.empty(shape=(len(inmat),len(inmat)))
    count = 0 
    for i in range(9):
        print(i,'/8 done')
        for j in range(len(yeo)):
            if yeo[j]==i:
                newline = []
                for k in range(9):
                    for l in range(len(yeo[0:len(inmat)])):
                        if yeo[l] == k:
                            newline.append(inmat[j][l])
                for col in range(len(new)):
                    new[count][col] = newline[col]
                count = count+1
    return new

def averageyeo(inmat, zero_midline=True):
    yeoavg = np.empty(shape=(8,8))
    
    if zero_midline:
        for mid in range(len(inmat)):
            inmat[mid][mid] = 0
        
    if len(inmat) == 10242:
        cutoffs = [0, 885, 1979, 3036, 5233, 6581, 7297, 9156, 10242]
    elif len(inmat) == 20484:
        cutoffs = [0, 1769, 3957, 6410, 10238, 12992, 14438, 18189, 20484]
    else:
        print('is matrix in fsaverage 5 space?')
    for row in range(8):
        for col in range(8):
            yeoavg[row][col]= np.mean(
                np.mean(
                    inmat[cutoffs[row]:cutoffs[row+1],cutoffs[col]:cutoffs[col+1]],
                    axis=1),
                axis=0)
    return yeoavg

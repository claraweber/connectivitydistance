import pandas as pd
import numpy as np
import nibabel as nib
from nilearn import datasets, signal, plotting
import matplotlib.pyplot as plt
import scipy.io as sio
import os

hm = plotting.plot_matrix(inmat,
                               figure=(10,10),
                               cmap ='viridis', 
                               vmin=0.7,
                               vmax=1,
                               reorder = False)

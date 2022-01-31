import numpy as np
import scipy.io as sio
import os 

# global path 
pth = '/Users/Desktop'

def mat2npz(matfile, index):
  ipth = os.path.join(pth, f'{matfile}.mat')
  opth = os.path.join(pth, f'{matfile}.npz')
  mat_i = sio.loadmat(file)
  mat_r = mat_i[index]
  np.savez_compressed(opth,funcdist = mat_r)
  os.remove(ipth)
  
def npz2mat(npzfile, index):
  ipth = os.path.join(pth, f'{matfile}.npz')
  opth = os.path.join(pth, f'{matfile}.mat')
  ipth = os.path.join
  mat_i = np.load(file)
  mat_r = mat_i[index]
  sio.savemat(opth,  {'index':mat_r})
  os.remove(ipth)
  
  #e.g. for all files in one directory
  
  for file in os.listdir(pth):
    if file.endswith('.mat'):
      mat = os.path.splitext(file)[0]
      mat2npz(mat)

# This is python script to convert .npy file to .mat file
# Since the .npy file is too large, v7.3 .mat file is used

import hdf5storage
import numpy as np

data = np.load('data.npy')
format = np.load('format.npy')
indices = np.load('indices.npy')
indptr = np.load('indptr.npy')
shape = np.load('shape.npy')

hdf5storage.savemat('data.mat', {'data':data}, format='7.3')
hdf5storage.savemat('format.mat', {'format':format}, format='7.3')
hdf5storage.savemat('indices.mat', {'indices':indices}, format='7.3')
hdf5storage.savemat('indptr.mat', {'indptr':indptr}, format='7.3')
hdf5storage.savemat('shape.mat', {'shape':shape}, format='7.3')

print('done')
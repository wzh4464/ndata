'''
% there are 5 npy files
% 'data.npy' contains the data values
% 'format.npy' 
% 'indices.npy' gives the row and column indices
% 'indptr.npy' gives the indices of the first element of each row
% 'shape.npy' gives the shape of the matrix

converts the npy files to a mat file
'''
import numpy as np
import scipy.io as io

data = np.load('data.npy')
format = np.load('format.npy')
indices = np.load('indices.npy')
indptr = np.load('indptr.npy')
shape = np.load('shape.npy')

print(data.shape)
print(format.shape)
print(indices.shape)
print(indptr.shape)
print(shape.shape)

# io.savemat('data.mat', {'data':data})
io.savemat('format.mat', {'format':format})
# io.savemat('indices.mat', {'indices':indices})
io.savemat('indptr.mat', {'indptr':indptr})
io.savemat('shape.mat', {'shape':shape})

# divid data and indices into 100 parts and save to mat files
for i in range(10000):
    io.savemat('data_part'+str(i)+'.mat', {'data':data[i*100000:(i+1)*100000]})
    io.savemat('indices_part'+str(i)+'.mat', {'indices':indices[i*100000:(i+1)*100000]})
    

print('done')

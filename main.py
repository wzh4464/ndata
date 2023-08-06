import numpy as np

# read 'indptr.npy'
indptr = np.load('indptr.npy')

# print the last 10 elements of 'indptr'
print(indptr[-10:])


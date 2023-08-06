% matlab script

% indices is 1x971812565 int32
load('indices.mat');
load('data.mat');
load('indptr.mat');
load('shape.mat');

% data to logical
data = logical(data);
indices = indices + 1;
indptr = indptr + 1;

% read csr sparse matrix
% mtx = sparse.csr_matrix((data,indices,indptr),shape=shape)

A = readCSR(data, indptr, indices, shape);

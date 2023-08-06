% matlab script

%% main

% % indices is 1x971812565 int32
% load('indices.mat');
% load('data.mat');
% load('indptr.mat');
% load('shape.mat');
% 
% % data to logical
% data = logical(data);
% indices = indices + 1;
% indptr = indptr + 1;

% read csr sparse matrix
% mtx = sparse.csr_matrix((data,indices,indptr),shape=shape)

% A = readCSR(data, indptr, indices, shape);

%% small test

data = logical([1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]);
indices = int32([1 4 5 7 9 12 13 15]);
% random 15 numbers from 1 to 7
indptr = int32(randi([1 7],1,15));
shape = int32([7 15]);

A = readCSR(data, indptr, indices, shape);

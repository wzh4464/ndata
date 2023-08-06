% matlab script

%% main

% % indices is 1x971812565 int32
load('indices.mat');
load('data.mat');
load('indptr.mat');
load('shape.mat');
% 
% % data to logical
% data = logical(data);
indices = indices + 1;
indptr = indptr + 1;

% read csr sparse matrix
% mtx = sparse.csr_matrix((data,indices,indptr),shape=shape)

% A = readCSR(data, indptr, indices, shape);

%% small test

% data = int32([1 1 10 10 1 10 1 10 1 1 10 10 1 1 10]);
data = double(data);
% indptr = int32([1 4 5 7 9 12 13 16]);
% shape = int64([7 15]);
% random 15 numbers from 1 to 7
% for i = 1:shape(1)
%     indices(indptr(i):indptr(i+1)-1) = randperm(shape(2), indptr(i+1)-indptr(i));
% end

A = readCSR(data, indptr, indices, shape);

% show dense matrix
% full(A)

% show sparse A(:10)
A(1:7,:)

% save A to file
save('A.mat', 'A', '-v7.3');

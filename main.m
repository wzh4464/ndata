%{
%File: /main.m
%Created Date: Saturday August 19th 2023
%Author: Hance Ng
%-----
%Last Modified: Monday, 21st August 2023 12:04:09 pm
%Modified By: the developer formerly known as Hance Ng at <wzh4464@gmail.com>
%-----
%HISTORY:
%Date      		By	Comments
%----------		---	---------------------------------------------------------
%
%19-08-232023	M1  change name	
%
%19-08-232023	HPC disp('S = ' + string(diag(S(1:20, 1:20))))
%}

% Load the matfile
% mf = matfile('smallA.mat');
% A = mf.smallA(1:100,1:100);

A = matfile('smallA.mat').smallA(2000:3000,3000:4000);

%% 
% load('smallA.mat')
% A = smallA;
% clear smallA

%% 
% [batch_size, n] = size(A);
batch_size = size(A, 1);

% batch_size = 10000;
% disp('batch_size =' + string(batch_size))

%% shrink A to make n divisible by batch_size
% n = floor(n/batch_size)*batch_size;
% A = A(:, 1:n);

%%
% M = m / batch_size;
% N = n / batch_size;

%%
k = batch_size;

%% 
[U, S, V] = svds(A, k);
disp('k = ' + string(k))
% disp first 20 S
disp('S = ' + string(diag(S(1:20, 1:20))))

title('Singular Values');
plot(diag(S(1:500, 1:500)), 'r.');
saveas(gcf, 'co-cluster_batch_size_' + string(batch_size) + '_k_' + string(k) + '_singular_values.png')

% save s to txt
dlmwrite('co-cluster_batch_size_' + string(batch_size) + '_k_' + string(k) + '_singular_values.txt', diag(S(1:500, 1:500)))

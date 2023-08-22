%{
%File: /main.m
%Created Date: Saturday August 19th 2023
%Author: Hance Ng
%-----
%Last Modified: Wednesday, 23rd August 2023 12:26:48 am
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

%% Load the matfile
mf = matfile('smallA.mat');
[m, n] = size(mf, 'smallA');
% load first 10000 lines of smallA without loading the whole file to memory
batch_size = 10000;
A = mf.smallA(1:batch_size, :);

%% ignore columns with all zeros and build the column map
col_map = (sum(A, 1) ~= 0);
A = A(:, col_map);

tic;
[U, S, V] = svdsketch(A);
toc;

s = diag(S);
stem(s(1:1000));
title('Singular Values');
saveas(gcf, 'co-cluster_batch_size_' + string(batch_size)  + '_singular_values.png')

% save s to txt
writematrix(s(1:1000), 'co-cluster_batch_size_' + string(batch_size)  + '_singular_values.txt', 'Delimiter', ' ')

% save size(A) to txt
writematrix(size(A), 'co-cluster_batch_size_' + string(batch_size)  + '_size_A.txt', 'Delimiter', ' ')

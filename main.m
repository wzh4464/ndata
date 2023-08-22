%{
%File: /main.m
%Created Date: Saturday August 19th 2023
%Author: Hance Ng
%-----
%Last Modified: Tuesday, 22nd August 2023 9:29:33 pm
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
% load first 1000 lines of smallA without loading the whole file to memory
A = mf.smallA(1:10000, :);

%% ignore columns with all zeros and build the column map
col_map = (sum(A, 1) ~= 0);
A = A(:, col_map);

[U,S,V] = svdsketch(A);

s = diag(S);
stem(s(1:1000));
title('Singular Values');
saveas(gcf, 'co-cluster_batch_size_' + string(batch_size) + '_k_' + string(k) + '_singular_values.png')

% save s to txt
writematrix(s(1:1000), 'co-cluster_batch_size_' + string(batch_size) + '_k_' + string(k) + '_singular_values.txt', 'Delimiter', ' ')

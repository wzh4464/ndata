%{
%File: /main.m
%Created Date: Saturday August 19th 2023
%Author: Hance Ng
%-----
%Last Modified: Thursday, 24th August 2023 3:43:38 pm
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

dbstop if error;
%% Load the matfile
tic;
mf = matfile('data/smallA.mat');
[m, n] = size(mf, 'smallA');
toc;
% load first 10000 lines of smallA without loading the whole file to memory
batch_size = 1000;
% A = mf.smallA(1:batch_size, :);
load('data/smallA.mat');
A = smallA(1:batch_size, :);
toc;
%% ignore columns with all zeros and build the column map
col_map = (sum(A, 1) ~= 0);
A = A(:, col_map);
toc;
tic;
cocluster(A, batch_size*0.7, batch_size/100);
toc;

% see the difference
% S_app is a vector, S_app(i) give the difference F-norm for matrix A - U * S(1:100*i, 1:100*i) * V'; i = 1:78
% S_app = zeros(1, 78);
% for i = 1:78
%     S_app(i) = norm(A - U(:, 1:100*i) * S(1:100*i, 1:100*i) * V(:, 1:100*i)', 'fro');
% end

% % plot the difference
% plot(S_app);
% title('Difference between A and U * S * V^T');
% saveas(gcf, 'result/co-cluster_batch_size_' + string(batch_size) + '_difference.png')

% % save S_app to txt
% writematrix(S_app, 'result/co-cluster_batch_size_' + string(batch_size) + '_difference.txt', 'Delimiter', ' ')

% s = diag(S);
% stem(s);
% title('Singular Values');
% saveas(gcf, 'result/co-cluster_batch_size_' + string(batch_size)  + '_singular_values.png')

% % save s to txt
% writematrix(s, 'result/co-cluster_batch_size_' + string(batch_size) + '_singular_values.txt', 'Delimiter', ' ')

% % save size(A) to txt
% writematrix(size(A), 'result/co-cluster_batch_size_' + string(batch_size) + '_size_A.txt', 'Delimiter', ' ')

% % save U to txt
% writematrix(U, 'result/co-cluster_batch_size_' + string(batch_size) + '_U.txt', 'Delimiter', ' ')

% % save V to txt
% writematrix(V, 'result/co-cluster_batch_size_' + string(batch_size) + '_V.txt', 'Delimiter', ' ')

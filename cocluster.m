%{
%File: /cocluster.m
%Created Date: Saturday August 19th 2023
%Author: Hance Ng
%-----
%Last Modified: Saturday, 19th August 2023 1:49:09 am
%Modified By: the developer formerly known as Hance Ng at <wzh4464@gmail.com>
%-----
%HISTORY:
%Date      		By	Comments
%----------		---	---------------------------------------------------------
%}


%% 
load('smallA.mat')
A = smallA;
clear smallA

%% 
[m, n] = size(A);

batch_size = 5000;
% disp('batch_size =' + string(batch_size))

%% shrink A to make n divisible by batch_size
% n = floor(n/batch_size)*batch_size;
% A = A(:, 1:n);

%%
% M = m / batch_size;
% N = n / batch_size;

%%
k = 10000;

%% 
tmpA = A(batch_size:batch_size*2-1, 1:batch_size);
[U, S, V] = svds(tmpA, k);
disp('k = ' + string(k))

title('Original Data');
subplot(1, 2, 1);
plot3(U(:, 1), U(:, 2), U(:, 3), 'r.');
title('3D Row Space');
subplot(1, 2, 2);
plot3(V(:, 1), V(:, 2), V(:, 3), 'r.');
title('3D Column Space');

%% save the picture
saveas(gcf, 'co-cluster_batch_size_' + string(batch_size) + '_k_' + string(k) + '.png')
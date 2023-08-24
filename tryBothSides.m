%{
%File: /tryBothSides.m
%Created Date: Thursday August 24th 2023
%Author: Hance Ng
%-----
%Last Modified: Thursday, 24th August 2023 10:00:51 pm
%Modified By: the developer formerly known as Hance Ng at <wzh4464@gmail.com>
%-----
%HISTORY:
%Date      		By	Comments
%----------		---	---------------------------------------------------------
%}

load('data/smallA.mat');
col_map = (sum(smallA, 1) ~= 0);
A = smallA(:, col_map);

numI = full(sum(A, 2))';
numJ = full(sum(A, 1));
[~, ~, B] = permuteMatrix(A, numI, numJ);

figure;
subplot(2, 1, 1);
spy(A);
subplot(2, 1, 2);
spy(B);
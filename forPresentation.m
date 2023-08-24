%{
%File: /forPresentation.m
%Created Date: Thursday August 24th 2023
%Author: Hance Ng
%-----
%Last Modified: Thursday, 24th August 2023 9:55:11 pm
%Modified By: the developer formerly known as Hance Ng at <wzh4464@gmail.com>
%-----
%HISTORY:
%Date      		By	Comments
%----------		---	---------------------------------------------------------
%}

load('data/smallA.mat');
col_map = (sum(smallA, 1) ~= 0);
A = smallA(:, col_map);
num = full(sum(A, 1))';
[~, ~, B] = permuteMatrix(A, 1:10000, num);
numB = full(sum(B, 1))';

% figure spy(A) and spy(B) vertically
figure;
subplot(2, 1, 1);
spy(A);
subplot(2, 1, 2);
spy(B);

% figure histogram
figure;
subplot(2, 1, 1);
stem(num);
subplot(2, 1, 2);
stem(numB);
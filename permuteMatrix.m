%{
%File: /permuteMatrix.m
%Created Date: Thursday August 24th 2023
%Author: Hance Ng
%-----
%Last Modified: Thursday, 24th August 2023 9:35:32 pm
%Modified By: the developer formerly known as Hance Ng at <wzh4464@gmail.com>
%-----
%HISTORY:
%Date      		By	Comments
%----------		---	---------------------------------------------------------
%}
% permuteMatrix
function [sortedI, sortedJ, A] = permuteMatrix(A, row_idx, col_idx)
    [sortedI, perI] = sort(row_idx);
    [sortedJ, perJ] = sort(col_idx);

    A = A(perI, perJ);
end
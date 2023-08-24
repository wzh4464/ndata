%{
%File: /draw_sub_matrices.m
%Created Date: Thursday August 24th 2023
%Author: Hance Ng
%-----
%Last Modified: Thursday, 24th August 2023 9:35:37 pm
%Modified By: the developer formerly known as Hance Ng at <wzh4464@gmail.com>
%-----
%HISTORY:
%Date      		By	Comments
%----------		---	---------------------------------------------------------
%}

% row_idx and col_idx are the indices of the submatrix
% row_idx = [1, 1, 1, 2, 2, 3, 1];
% col_idx = [1, 2, 3, 1, 2, 3, 3];
% A = [11, 12, 13, 14, 15, 16, 17;
%      21, 22, 23, 24, 25, 26, 27;
%      31, 32, 33, 34, 35, 36, 37;
%      41, 42, 43, 44, 45, 46, 47;
%      51, 52, 53, 54, 55, 56, 57;
%      61, 62, 63, 64, 65, 66, 67;
%      71, 72, 73, 74, 75, 76, 77];

% permutae A according to row_idx and col_idx, group one are top left and group 3 are bottom right
A = smallA(1:1000, :);

if size(row_idx, 2) == 1
    row_idx = row_idx';
    col_idx = col_idx';
    assert(size(row_idx, 1) == 1);
end

%if I not defined, define it
if ~exist('I', 'var')
    k = 5;
    I = false(k, numel(row_idx));
    J = false(k, numel(col_idx));

    linearIndices = sub2ind([k, numel(row_idx)], row_idx, 1:numel(row_idx));
    I(linearIndices) = true;
    linearIndices = sub2ind([k, numel(col_idx)], col_idx, 1:numel(col_idx));
    J(linearIndices) = true;
end

for i = 1:k
    numI(i) = sum(I(i, :));
end

for i = 1:k
    numJ(i) = sum(J(i, :));
end

[sortedClusterI, indSortedClusterI] = sort(numI);
[sortedClusterJ, indSortedClusterJ] = sort(numJ);

% substitute i with indSortedClusterI(i) from now on
row_idx = indSortedClusterI(row_idx);
col_idx = indSortedClusterJ(col_idx);
I = false(k, numel(row_idx));
J = false(k, numel(col_idx));

linearIndices = sub2ind([k, numel(row_idx)], row_idx, 1:numel(row_idx));
I(linearIndices) = true;
linearIndices = sub2ind([k, numel(col_idx)], col_idx, 1:numel(col_idx));
J(linearIndices) = true;





figure;

[sortedI, sortedJ, ~] = permuteMatrix(A, row_idx, col_idx);

% for i = 1:numel(row_idx)
%     for j = 1:numel(col_idx)
%         B(i, j) = 11*row_idx(i) + col_idx(j);
%     end
% end
[i, j] = ndgrid(sortedI, sortedJ);
B = 11 * i + j;

C = arrayfun(@keyHash, B);

% draw B, with colorid is B(i, j)
imagesc(C);
% colormap(jet);
% colorbar;
% % draw the grid
% hold on;
% for i = 1:size(row_idx, 2) + 1
%     plot([0.5, size(row_idx, 2) + 0.5], [i + 0.5, i + 0.5], 'k-');
% end
% for i = 1:size(col_idx, 2) + 1
%     plot([i + 0.5, i + 0.5], [0.5, size(col_idx, 2) + 0.5], 'k-');
% end
% hold off;
% axis equal;
% axis off;


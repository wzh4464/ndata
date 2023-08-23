%{
%File: /cocluster.m
%Created Date: Saturday August 19th 2023
%Author: Hance Ng
%-----
%Last Modified: Wednesday, 23rd August 2023 4:42:03 pm
%Modified By: the developer formerly known as Hance Ng at <wzh4464@gmail.com>
%-----
%HISTORY:
%Date      		By	Comments
%----------		---	---------------------------------------------------------
%}

function [row_cluster, col_cluster] = cocluster(X, k, k2)
    % COCLUSTER Co-clustering algorithm
    %   [row_cluster, col_cluster] = COCLUSTER(X, max_iter, tol, k)
    %   performs co-clustering on the data matrix X. The
    %   algorithm runs for at most max_iter iterations or until the objective
    %   function changes by less than tol.
    tic;
    [U, S, V] = svdsketch(X);
    toc; fprintf('for svd\n');
    % count singular values bigger than s_tol
    % s_tol = 1e-1;
    % s = diag(S);
    % s = s(1:k);


    % do k-means on U and V
    U = U(:, 1:k);
    V = V(:, 1:k);
    tic;
    [row_idx, row_cluster, row_dist, row_sumd] = kmeans(U, k2);
    toc; fprintf('for row\n');
    tic;
    [col_idx, col_cluster, col_dist, col_sumd] = kmeans(V, k2);
    toc; fprintf('for col\n');

    % compute I,J for each cluster
    % for i = 1:k
    %     I(i, :) = row_idx == i;
    %     J(i, :) = col_idx == i;
    % end
    row_idx = row_idx';
    col_idx = col_idx';

    I = false(k, numel(row_idx));
    J = false(k, numel(col_idx));

    linearIndices = sub2ind([k, numel(row_idx)], row_idx, 1:numel(row_idx));
    I(linearIndices) = true;
    linearIndices = sub2ind([k, numel(col_idx)], col_idx, 1:numel(col_idx));
    J(linearIndices) = true;

    % scoreMatrix = zeros(k, k);

    % for i = 1:k
    %     for j = 1:k
    %         % compute score for each submatrix
    %         scoreMatrix(i, j) = score(X, I(i, :), J(j, :));
    %     end
    % end
    [Igrid, Jgrid] = meshgrid(1:k);
    scoreMatrix = arrayfun(@(i, j) score(X, I(i, :), J(j, :)), Igrid, Jgrid);

    % save scoreMatrix
    save('result/scoreMatrix.mat', 'scoreMatrix', '-v7.3');
    save('result/function.mat');



    % initialize loss
    %! WIP
end

% function result = score(X, I, J)
%     % SCORE Compute the compatibility for submatrix X_IJ
%     %
%     %   X: the data matrix
%     %   I: the row cluster assignment; I is logical vector.
%     %   J: the column cluster assignment; J is logical vector.

%     lenI = sum(I);
%     lenJ = sum(J);

%     S1 = abs(corrcoef(X(I, J)) - eye(lenJ));
%     S2 = abs(corrcoef(X(I, J)') - eye(lenI));

%     result = min([scoreHelper(lenJ, S1), scoreHelper(lenI, S2)]);
% end

% function s = scoreHelper(length, C)
%     s = 1 - 1 / (length - 1) * sum(C);
% end

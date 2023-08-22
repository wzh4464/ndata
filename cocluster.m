%{
%File: /cocluster.m
%Created Date: Saturday August 19th 2023
%Author: Hance Ng
%-----
%Last Modified: Tuesday, 22nd August 2023 8:59:13 pm
%Modified By: the developer formerly known as Hance Ng at <wzh4464@gmail.com>
%-----
%HISTORY:
%Date      		By	Comments
%----------		---	---------------------------------------------------------
%}

function [row_cluster, col_cluster] = cocluster(X, max_iter, tol)
    % COCLUSTER Co-clustering algorithm
    %   [row_cluster, col_cluster] = COCLUSTER(X, max_iter, tol, k)
    %   performs co-clustering on the data matrix X. The
    %   algorithm runs for at most max_iter iterations or until the objective
    %   function changes by less than tol.
 
    [U, S, V] = svdsketch(X);
    % count singular values bigger than s_tol
    s_tol = 1e-1;
    s = diag(S);
    s = s(s > s_tol);
    k = length(s);

    % do k-means on U and V
    U = U(:, 1:k);
    V = V(:, 1:k);
    [row_idx, row_cluster, row_dist, row_sumd] = kmeans(U, k);
    [col_idx, col_cluster, col_dist, col_sumd] = kmeans(V, k);

    % initialize loss
    %! WIP
end

function result = score(X, I, J)
    % SCORE Compute the compatibility for submatrix X_IJ
    %
    %   X: the data matrix
    %   I: the row cluster assignment; I is logical vector.
    %   J: the column cluster assignment; J is logical vector.

    lenI = sum(I);
    lenJ = sum(J);

    S1 = abs(corrcoef(X(I, J)) - eye(lenJ));
    S2 = abs(corrcoef(X(I, J)') - eye(lenI));

    result = min([scoreHelper(lenJ, S1), scoreHelper(lenI, S2)]);
end

function s = scoreHelper(length, C)
    s = 1 - 1 / (length - 1) * sum(C);
end

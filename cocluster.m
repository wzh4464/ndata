%{
%File: /cocluster.m
%Created Date: Saturday August 19th 2023
%Author: Hance Ng
%-----
%Last Modified: Thursday, 24th August 2023 4:35:47 pm
%Modified By: the developer formerly known as Hance Ng at <wzh4464@gmail.com>
%-----
%HISTORY:
%Date      		By	Comments
%----------		---	---------------------------------------------------------
%}

function [row_cluster, col_cluster] = cocluster(X, scale, k)
    % COCLUSTER Co-clustering algorithm
    %   [row_cluster, col_cluster] = COCLUSTER(X, max_iter, tol, k)
    %   performs co-clustering on the data matrix X. The
    %   algorithm runs for at most max_iter iterations or until the objective
    %   function changes by less than tol.

    fprintf('begin cocluster\n');

    tic;
    [U, ~, V] = svds(X, scale);
    toc; fprintf('for svd\n');

    % save U, S, V % tic; % save('result/svd.mat', 'U', 'S', 'V', '-v7.3'); % toc; fprintf('for save\n');

    % do k-means on U and V
    % U = U(:, 1:scale);
    % V = V(:, 1:scale);
    tic;
    [row_idx, row_cluster, row_dist, row_sumd] = kmeans(U, k);
    toc; fprintf('for row\n');
    tic;
    [col_idx, col_cluster, col_dist, col_sumd] = kmeans(V, k);
    toc; fprintf('for col\n');

    % save row_idx, row_cluster, row_dist, row_sumd, col_idx, col_cluster, col_dist, col_sumd
    save('result/kmeans_' + string(scale) + '.mat', 'row_idx', 'row_cluster', 'row_dist', 'row_sumd', 'col_idx', 'col_cluster', 'col_dist', 'col_sumd', '-v7.3');
    fprintf('for save kmeans result\n');

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

    scoreMatrix = zeros(k, k);
    disp('begin busy');
    % open a file 'result/scoreMatrix.txt'
    try
        % feature('numcores')
        % 
        % if isempty(gcp('nocreate'))
        %     parpool(feature('numcores'));
        % end

        % parfor i = 1:k
        for i = 1:k
            % open file for current worker
            fid(i) = fopen(sprintf('result/scoreMatrix_%d_scale_%d.txt', i, scale), 'w');

            for j = 1:k
                % compute score for each submatrix
                tic;
                scoreMatrix(i, j) = score(X, I(i, :), J(j, :));
                fprintf(fid(i), '%d %d %f %f\n', i, j, scoreMatrix(i, j), toc);
                % toc;
                fprintf('i = %d, j = %d, score = %f\n', i, j, scoreMatrix(i, j));
            end

            fclose(fid(i)); % close file for current worker
            fprintf('worker %d finished\n', i);
        end

    catch ME
        delete(gcp('nocreate')); % close the parallel pool
        save('result/scoreMatrix_' + string(scale) + '.mat', 'scoreMatrix', '-v7.3');
        save('result/function_' + string(scale) + '.mat', '-v7.3');
        rethrow(ME); % rethrow the error
    end

    % [Igrid, Jgrid] = meshgrid(1:k);
    % scoreMatrix = arrayfun(@(i, j) score(X, I(i, :), J(j, :)), Igrid, Jgrid);

    % save scoreMatrix
    save('result/scoreMatrix_' + string(scale) + '.mat', 'scoreMatrix', '-v7.3');
    save('result/function_' + string(scale) + '.mat');

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

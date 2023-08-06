function S = readCSR(data, indptr, indices, shape)

% data is value of each non-zero element
% indptr[i,i+1] give the part of indices that correspond to row i
% indices give the column of each element
% shape is the shape of the matrix
% S is the sparse matrix: OUTPUT

% allocate memory for IJ
% IJ = zeros(length(data), 2, 'int64');

% for i = 1:shape(1)
%     IJ(indptr(i):indptr(i + 1) - 1, :) = [i .* ones(indptr(i + 1) - indptr(i), 1, 'int64'), indices(indptr(i):indptr(i + 1) - 1)'];
% end

n = numel(indptr) - 1; % Number of rows
row_counts = diff(indptr); % Number of nonzero elements in each row
I = repelem((1:n)', row_counts); % Repeat row index for each nonzero element

% Extract the column indices (J) using indptr
J = arrayfun(@(startIdx, endIdx) indices(startIdx:endIdx - 1), indptr(1:end - 1), indptr(2:end), 'UniformOutput', false);
J = cell2mat(J)';

IJ = [I, J]; % Concatenate row and column indices

% assert(isequal(IJ, IJ2), 'IJ and IJ2 are not equal');

S = sparse(IJ(:,1), IJ(:,2), data, shape(1), shape(2), length(data));

end
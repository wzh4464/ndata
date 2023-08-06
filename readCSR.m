function S = readCSR(data, indptr, indices, shape)

% data is value of each non-zero element
% indptr give the column of each element
% indices[i,i+1] give the part of indices that correspond to row i
% shape is the shape of the matrix
% S is the sparse matrix: OUTPUT

IJ = [];
for i = 1:length(indptr)-1
    for j = indptr(i):indptr(i+1)-1
        IJ = [IJ; i, indices(j)];
    end
end

S = sparse(IJ(:,1), IJ(:,2), data, shape(1), shape(2));

end
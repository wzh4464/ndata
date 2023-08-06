function S = readCSR(data, indptr, indices, shape)

% data is value of each non-zero element
% indptr give the column of each element
% indices[i,i+1] give the part of indices that correspond to row i
% shape is the shape of the matrix
% S is the sparse matrix: OUTPUT

data_ptr = 1;
IJ = zeros(length(data),2);
for i = 1:shape(1)-1
    for j = indptr(i):indptr(i+1)+1
        IJ(data_ptr,:) = [i, indices(j)];
        data_ptr = data_ptr + 1;
    end
end

% numWorkers = 8;
% parpool(numWorkers);

% spmd
%     % Get the number of workers and the ID of this worker
%     workerID = spmdIndex;

%     % Compute the indices of the rows to process on this worker
%     rowsPerWorker = ceil(length(indptr) / numWorkers);
%     startRow = (workerID - 1) * rowsPerWorker + 1;
%     endRow = min(workerID * rowsPerWorker, length(indptr));

%     % Process the rows on this worker
%     tempIJ = cell(endRow - startRow + 1, 1);

%     for i = startRow:endRow
%         temp = zeros(indptr(i + 1) - indptr(i), 2);
%         k = 1;

%         for j = indptr(i):indptr(i + 1) - 1
%             temp(k, :) = [i, indices(j)];
%             k = k + 1;
%         end

%         tempIJ{i - startRow + 1} = temp;
%     end

%     % Combine the results from all workers
%     IJ = cat(1, tempIJ{:});
%     IJ = spmdCat(IJ, 1, 1);
% end

% IJ = IJ{1};

S = sparse(IJ(:,1), IJ(:,2), data, shape(1), shape(2), length(data));

end
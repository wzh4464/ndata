function saveSmallA(row_num, A)
%SAVESMALLA Save row_num rows of A to file smallA_row_num.mat
%   if A is not define, load A.mat
if nargin < 2
    % load A from A.mat
    % load('A.mat');
    load('A.mat', 'A');
end

%   save row_num rows of A to file smallA_row_num.mat
smallA = A(1:row_num, :);

%   prepare dir

if ~exist('data', 'dir')
    mkdir('data');
end

save(['data/smallA_' num2str(row_num) '.mat'], 'smallA', '-v7.3');

end



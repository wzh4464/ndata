function printAfig(A)

if nargin < 1
    load('A.mat','A');
end

spy(A);
title('A Matrix');
xlabel('Column');
ylabel('Row');

savefig('pic/A_sparsity_pattern.fig')

end
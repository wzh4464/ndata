function result = score(X, I, J)
    % SCORE Compute the compatibility for submatrix X_IJ
    %
    %   X: the data matrix
    %   I: the row cluster assignment; I is logical vector.
    %   J: the column cluster assignment; J is logical vector.
    
    % I = logical(I);
    % J = logical(J);

    lenI = sum(I);
    lenJ = sum(J);

    S1 = abs(corrcoef(X(I, J)) - eye(lenJ));
    S2 = abs(corrcoef(X(I, J)') - eye(lenI));

    result = min([scoreHelper(lenJ, S1), scoreHelper(lenI, S2)]);
end

function s = scoreHelper(length, C)
    s = 1 - 1 / (length - 1) * sum(C);
end
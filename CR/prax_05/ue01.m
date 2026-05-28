function [L, R] = lr(A)
    n=size(A,1);
    L = eye(n);
    R = A;
    for s=1:n-1
        for r=s+1:n
            lambda = R(r, s) / R(s, s);
            R(r, :) = R(r, :) + -lambda * R(s, :);
            L(r, s) = lambda;
        end
    end
end

A = [2 1 -1 3;
    4 1 0 7;
    -2 -1 4 -5;
    2 2 3 -1];

[L1, R1] = lr(A);

isequal(L1*R1, A)

[L, U, P] = lu(A);
L2 = L;
R2=U;

isequal(L2*R2, P*A)
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

function x = solve(L, R, b)
    function x = back_substitution(R, z)
        n = size(R, 1);
        x = zeros(n, 1);
        for i=n:-1:1
            cum = 0;
            for j = n:-1:i+1
                cum = cum + R(i, j) * x(j);
            end
            x(i) = 1/R(i, i) * (z(i) - cum);
        end
    end

    function x = forward_elimination(L, z)
        n = size(L, 1);
        x = zeros(n, 1);
        for i = 1:n
            cum = 0;
            for j = 1:i-1
                cum = cum + L(i, j) * x(j);
            end
            x(i) = (z(i) - cum) / L(i, i);
        end
    end

    z = forward_elimination(L, b);
    x = back_substitution(R, z);
end

A = [2 1 -1 3;
    4 1 0 7;
    -2 -1 4 -5;
    2 2 3 -1];

b = [1 2 3 4]';

% 1. Compare to lu

[L1, R1] = lr(A);

isequal(L1*R1, A);

[L, U, P] = lu(A);
L2 = L;
R2=U;

isequal(L2*R2, P*A);

% 2. Solve

x1 = solve(L1, R1, b);

x2 = A \ b;

x1
x2
isequal(x1, x2)
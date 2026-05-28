function x = solve(A, b)
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

    [L, R] = lr(A);
    z = forward_elimination(L, b);
    x = back_substitution(R, z);
end

% a. Hilbert matrix

for n=5:5:20
    disp(n);
    [I, J] = meshgrid(1:n, 1:n);
    A = 1 ./ (I + J - 1);
    
    b = sum(J .* A, 2);
    x = 1:n;
    
    x_calc = solve(A, b);
end

% b. Wikinson matrix

n=5;

W = tril(-ones(n)) + diag([2*ones(1,n-1) 1]) + [zeros(n,n-1) ones(n,1)];

c1 = cond(W, 1)
c_inf = cond(W, inf)

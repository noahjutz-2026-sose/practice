function x = ruecksubstitution(R, z)
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

ruecksubstitution([2 1 3; 0 -1 2; 0 0 2], [9 8 6])

function x = vorwaertselimination(L, z)
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

vorwaertselimination([1 0 0; 2 1 0; -1 0 1], [3 7 -7])

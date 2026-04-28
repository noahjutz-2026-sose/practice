function s = computeSum(x)
    s = x(1);
    c = 0;
    for k=2:length(x)
        y = x(k) - c;
        temp = s + y;
        c = (temp - s) - y;
        s = temp;
    end
end

% x = [1e-24, 1e-25, 1e-23, 2e-24, 1e-25, 1e-25, 1e-25];
% computeSum(x);

% x = rand(1, 100) * 1e-24;
% computeSum(x)

N=10000;
S=zeros(4, N);
for n=1:N
    x = ones(1, n) * 1/10;
    S(1, n) = computeSum(x);
    S(2, n) = sum(x);
    cum = cumsum(x);
    S(3, n) = cum(end);
    S(4, n) = n / 10;
end

diffs = S(1:3, :) - S(4, :);
diffs = diffs ./ (1:N);
diffs = abs(diffs);
plot(1:N, diffs);
legend('ComputeSum', 'Sum', 'Cumsum');
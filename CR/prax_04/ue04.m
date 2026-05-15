v = 1:25;
A = zeros(5);
A(:) = v;

% 4.4.1

my_any = any(mod(A, 3), 'all');
my_all = all(mod(A, 3), 'all');

% 4.4.2

function u = nonneg(v)
    u = any(v >= 0, 1);
    u = v(logical(u));
end

filtered_nonneg = nonneg([-1 0.4 -2 3 0]);

% 4.4.3

function [value, index] = pivot1(v)
    if v == 0
        value = 0;
        index = -1;
        return;
    end
    [value, index] = max(v);
end

% 4.4.4

function [value, index] = pivot2(v, start)
    [value, index] = pivot1(v(start:end));
end

[max_v, max_i] = pivot2([2 0 0 0], 2);
disp(max_v);
disp(max_i);

xs = [-1 0 2 3]';
ys = [2 3 1 2]';

n = 3;

% Lagrange

function l = lagrange(x, j, n, xs, ys)
    l = 1;
    for k=0:n
        if k == j
            continue;
        end

        part = (x - xs(k+1)) / (xs(j+1) - xs(k+1));
        l = l * part;
    end
end

function y = interp_l(x, n, xs, ys)
    y = 0;
    for i=0:n
        y = y + ys(i + 1) * l(x, i, n, xs, ys);
    end
end



% Newton

function omega = newton(x, j, xs)
    omega = 1;
    for i=0:j-1
        omega = omega * (x - xs(i+1));
    end
end

function d = divdiff(xs, ys, i, j)
    if i == j
        d = ys(i+1);
        return;
    end
    l = divdiff(xs, ys, i+1, j);
    r = divdiff(xs, ys, i, j-1);
    d = (l-r)/(xs(j+1)-xs(i+1));
end

function y = interp_n(x, n, xs, ys)
    y = 0;
    for i=0:n
        coeff = divdiff(xs, ys, 0, i);
        omega = newton(x, i, xs);
        y = y + coeff * omega;
    end
end

figure;
xValues = linspace(-1, 3, 100);
yValues = arrayfun(@(x) interp_n(x, n, xs, ys), xValues);
plot(xValues, yValues, 'b-', 'DisplayName', 'interp');
hold on;
scatter(xs, ys, 'ro');
xlabel('x');
ylabel('Interpolated y');
title('Lagrange Interpolation');
legend;
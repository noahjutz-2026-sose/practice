xs = [-1 0 2 3]';
ys = [2 3 1 2]';

n = 3;

function l = l(x, j, n, xs, ys)
    l = 1;
    for k=0:n-1
        if k == j
            continue;
        end

        part = (x - xs(k+1)) / (xs(j+1) - xs(k+1));
        l = l * part;
    end
end

function y = interp(x, n, xs, ys)
    y = 0;
    for i=0:n
        y = y + ys(i + 1) * l(x, i, n, xs, ys);
    end
end

figure;
xValues = linspace(-1, 3, 100);
yValues = arrayfun(@(x) interp(x, n, xs, ys), xValues);
plot(xValues, yValues, 'b-', 'DisplayName', 'interp');
hold on;
scatter(xs, ys, 'ro');
xlabel('x');
ylabel('Interpolated y');
title('Lagrange Interpolation');
legend;
phi = @(x) 1/sqrt(2*pi) * exp(-x^2/2);

n = 5;
x = -1:(2/n):1;
y = arrayfun(phi, x);
p = polyfit(x, y, n);

% Figure

clf;
figure(1);
hold on;
xs = linspace(-1, 1);
plot(x, y, 'o');
plot(xs, polyval(p, xs));
plot(xs, arrayfun(phi, xs));
legend;

% Integrate

P = polyint(p);
integral_value = polyval(P, 1) - polyval(P, -1)
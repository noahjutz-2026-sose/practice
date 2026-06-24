xs = [0 1 2];
ys = [1 2 2];

A = [1 0 0 0 0 0 0 0
     1 1 1 1 0 0 0 0
     0 0 0 0 1 1 1 1
     0 0 0 0 1 2 4 8
     0 1 2 3 0 -1 -2 -3
     0 0 2 6 0 0 -2 -6
     0 0 2 0 0 0 0 0
     0 0 0 0 0 0 2 12];

y = [1 2 2 2 0 0 0 0]';

c = A \ y;

clf;
figure(1);
hold on;
plot(xs, ys, 'ro', 'MarkerFaceColor', 'r');
x1 = linspace(0, 1);
x2 = linspace(1, 2);
y1 = polyval(flip(c(1:4)), x1);
y2 = polyval(flip(c(5:end)), x2);
plot(x1, y1);
plot(x2, y2);
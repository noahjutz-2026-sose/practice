x = [2 4 6 8 10]';
y = [2 4 3 5 6]';

A = [[2 1]
    [4 1]
    [6 1]
    [8 1]
    [10 1]];

theta = A \ y;

scatter(x, y, 'filled', 'DisplayName', 'Datenpunkte');
hold on;
plot(x, theta(1)*x + theta(2), 'LineWidth', 2, 'DisplayName', 'Ausgleichsgerade');
xlabel('x'); ylabel('y'); legend('Location', 'best'); grid on;
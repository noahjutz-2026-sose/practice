fplot(@sin, [0, 2*pi], "--");
hold on
fplot(@cos, [0, 2*pi], "--");
x=0:.5:2*pi;
plot(x, sin(x), "o", 'LineWidth', 3);
plot(x, cos(x), "o", 'LineWidth', 3);
hold off
xlabel('x');
ylabel('y');
legend("sin", "cos", "sin discrete", "cos discrete");
title('Trigonometric Functions');
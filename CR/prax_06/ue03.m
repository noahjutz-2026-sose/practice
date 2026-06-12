data1 = load("data/Datensatz1.mat");
data2 = load("data/Datensatz2.mat");
data3 = load("data/Datensatz3.mat");
data4 = load("data/Datensatz4.mat");

% Data1

figure
x = data1.xMeasure;
y = data1.yMeasure;
plot(x, y, 'o');

% Data1 Linear model

res = [x' x'.^0] \ y';
m = res(1);
b = res(2);

hold on;

idx = linspace(0, 10);
plot(idx, m*idx + b, 'DisplayName', 'Linear');

% Data1 Quadratic model

A = [x'.^2 x'.^1 x'.^0];
res = A \ y';
plot(idx, res(1)*idx.^2 + res(2)*idx + res(3), 'DisplayName', 'Quadratic');

% Data1 Polynomial Model

A = [x'.^5 x'.^4 x'.^3 x'.^2 x'.^1 x'.^0];
res = A \ y';
plot(idx, res(1)*idx.^5 + res(2)*idx.^4 + res(3)*idx.^3 + res(4)*idx.^2 + res(5)*idx + res(6), 'DisplayName', 'Quintic');

% Data1 Exponential Model

A = [x' x'.^0];
res = A \ log(y');
plot(idx, exp(res(1)) + exp(res(2)) * idx, 'DisplayName', 'exp');

% Data1 Trig Model

omega = .4;
A = [x'.^0 cos(x'.*omega) sin(x'.*omega)];
res = A \ y';
plot(idx, res(1) + cos(idx'.*omega) * res(2) + sin(idx'.*omega) * res(3), 'DisplayName', 'Trigonometric');

legend;

% Data2

figure
x = data2.xMeasure;
y = data2.yMeasure;
plot(x, y, 'o', 'DisplayName', 'Data2');
hold on;

% Data2 Quadratic

A = [x'.^2 x'.^1 x'.^0];
res = A \ y';
plot(idx, idx'.^2 * res(1) + idx'.^1 * res(2) + idx'.^0 * res(3), 'DisplayName', 'Quadratic');

legend;

% Data3

figure
x = data3.xMeasure;
y = data3.yMeasure;
plot(x, y, 'o', 'DisplayName', 'Data3');
hold on;

% Data3 Trigonometric

omega = 1;
A = [x'.^0 cos(x'.*omega) sin(x'.*omega)];
res = A \ y';
plot(idx, res(1) + cos(idx'.*omega) * res(2) + sin(idx'.*omega) * res(3), 'DisplayName', 'Trigonometric');

% Data4

figure
x = data4.xMeasure;
y = data4.yMeasure;
plot(x, y, 'o', 'DisplayName', 'Data4');
hold on;

% Data4 Circular

Z = (x.^2 + y.^2)';
A = [x' y' x'.^0];
theta = A \ Z;
xc = theta(1) / 2;
yc = theta(2) / 2;
r = sqrt(theta(3) - xc^2 - yc^2);

thetaCircle = linspace(0, 2*pi, 100);
xCircle = xc + r * cos(thetaCircle);
yCircle = yc + r * sin(thetaCircle);
plot(xCircle, yCircle, 'DisplayName', 'Circular Fit');

legend;
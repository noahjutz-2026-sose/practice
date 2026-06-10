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
legend;

% Data1 Polynomial model


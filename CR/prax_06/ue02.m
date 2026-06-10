data = readmatrix("data/2020-05-18_corona_data_germany.csv");
data = data(:, 2:6); % d, m, y, cases, deaths
data = data(:, end-1:end); % cases, deaths
data = data(end:-1:1, :); % reverse

% a) visualize

figure
yyaxis left
plot(data(:,1), 'c'); hold on;
plot(movmean(data(:,1), 7), 'b', 'LineWidth', 2); ylabel('Cases');

yyaxis right
plot(data(:,2), 'm');
plot(movmean(data(:,2), 7), 'r', 'LineWidth', 2); ylabel('Deaths');

title('Germany Corona Data with 7-Day Moving Average');
legend('Daily Cases', '7-Day Mean Cases', 'Daily Deaths', '7-Day Mean Deaths');

% b)

x = 1:85;
y = data(x, 1); % cases at highest growth
idx = find(y > 0);
y = y(idx);
x = x(idx);
Y = log(y);


A = [x' x'.^0];

Theta = A \ Y;
a = Theta(1);
c = exp(Theta(2));

hold on
x_fit = linspace(min(x), max(x), 100);
y_fit = c * exp(a * x_fit);
plot(x_fit, y_fit, 'g', 'LineWidth', 2);

data = readmatrix("data/2020-05-18_corona_data_germany.csv");
data = data(:, 2:6); % d, m, y, cases, deaths
data = data(:, end-1:end); % cases, deaths

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

x = 30:50;
y = data(x, 1); % cases at highest growth
Y = log(y);

A = [x' x'.^0];
A
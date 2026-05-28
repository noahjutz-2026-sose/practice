% a. Figures

D = readmatrix('Raw Data.csv', 'NumHeaderLines', 1);

t = D(:,1);
ax = D(:,2);
ay = D(:,3);
az = D(:,4);
norm = D(:,5);

figure;
plot(t, [ax, ay, az]);
xlabel('Zeit (s)'); ylabel('Beschl (m/s^2)');
legend('x', 'y', 'z');
title('Komponentenverlauf');

figure;
histogram(ax); hold on;
histogram(ay);
histogram(az);
histogram(norm);
legend('x', 'y', 'z', 'norm');
title('Verteilung');

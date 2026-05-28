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

% figure;
% histogram(ax); hold on;
% histogram(ay);
% histogram(az);
% histogram(norm);
% legend('x', 'y', 'z', 'norm');
% title('Verteilung');

% b. mean and var

mu_x = mean(ax); var_x = var(ax);
mu_y = mean(ay); var_y = var(ay);
mu_z = mean(az); var_z = var(az);

hold on;
yline(mu_x, 'r--', 'Mean X'); yline(mu_x + sqrt(var_x), 'r:'); yline(mu_x - sqrt(var_x), 'r:');
yline(mu_y, 'g--', 'Mean Y'); yline(mu_y + sqrt(var_y), 'g:'); yline(mu_y - sqrt(var_y), 'g:');
yline(mu_z, 'b--', 'Mean Z'); yline(mu_z + sqrt(var_z), 'b:'); yline(mu_z - sqrt(var_z), 'b:');
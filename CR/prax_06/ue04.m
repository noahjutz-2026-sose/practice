data = readmatrix("data/PendelAccel.csv");
t = data(:, 1);
ax = data(:, 2);
ay = data(:, 3);
az = data(:, 4);

% a) find axis with highest amplitude (x)

figure;
plot(t, ax, 'r', t, ay, 'g', t, az, 'b');
legend('Ax', 'Ay', 'Az');
hold on;

% b) Nichtlineares Modell aufstellen

alpha = .6;
delta = -.060;
omega = 2.4;
phi = pi;
plot(t, alpha * exp(-delta .* t) .* sin(omega .* t + phi));

% c) Optimieren

function y = yVec(t, theta)
    alpha = theta(1);
    delta = theta(2);
    omega = theta(3);
    phi   = theta(4);
    
    y = alpha .* exp(-delta .* t) .* cos(omega .* t + phi);
end

theta = [alpha, delta, omega, phi];

thetaStar = lsqnonlin(@(theta) yVec(t, theta) - ax, theta);
plot(t, yVec(t, thetaStar), 'LineWidth', 2);
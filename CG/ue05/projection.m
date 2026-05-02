% CG Übung 5, Aufgabe 3

x_min = -10;
x_max = 10;
y_min = -5;
y_max = 5;
n = 1;
f = 101;

P = [2/(x_max-x_min), 0, 0, -(x_max+x_min)/(x_max-x_min);
    0, 2/(y_max-y_min), 0, -(y_max+y_min)/(y_max-y_min);
    0, 0, 2/(n-f), -(f+n)/(f-n);
    0, 0, 0, 1];

w = 10;
h = 5;
x_vp = 0;
y_vp = 0;

W = [w/2, 0, 0, x_vp + w/2;
    0, h/2, 0, y_vp + h/2;
    0, 0, (f-n)/2, (f+n)/2;
    0, 0, 0, 1];

t1 = [-9.5, 5, 10;
    -4.5, 5, 2.5;
    4, 100, 33;
    1, 1, 1];

t2 = [-10, 5.5, 9.5;
    -3, -5, 5;
    101, 50, 60;
    1, 1, 1];

% Projection

t1p = P * t1;
t2p = P * t2;
t1w = W * t1p;
t2w = W * t2p;

draw(t1w, t2w);

disp(t1w);
disp(t2w);

function draw(varargin)
    for i = 1:nargin
        V = varargin{i};
        P = V(1:3, :) ./ V(4, :);
        fill3(P(1, :), P(2, :), P(3, :), rand(1, 3), 'FaceAlpha', 0.5);
        hold on;
    end
    grid on;
    axis equal;
    axis([0 10 0 5]);
    for az = 0:5:360
        view(az, 30)
        drawnow
    end
    view(0, 90)
    hold off;
end
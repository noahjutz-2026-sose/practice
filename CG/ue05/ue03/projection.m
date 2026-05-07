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

w = 100;
h = 50;
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

t2 = [-10, 10, 9.5;
    -3, -5, 5;
    101, 50, 2;
    1, 1, 1];

% Projection

t1p = P * t1;
t2p = P * t2;
t1w = W * t1p;
t2w = W * t2p;

% draw(t1w, t2w);

disp(t1w);
disp(t2w);

% Rasterization

zbuff = ones(h, w) * inf;
raster = ones(h, w, 3);

for t = {t1w, t2w}
    t = t{1};
    t_2d = [t(1:2, :); 1, 1, 1];
    color = rand(1, 3);
    for x=1:w
        for y=1:h
            b = t_2d \ [x; y; 1];
            if all(b >= 0)
                z = b' * t(3, :)';
                if z < zbuff(y, x)
                    zbuff(y, x) = z;
                    raster(y, x, :) = color;
                end
            end
        end
    end
end

% Drawing pixels

hold on;
for y = 1:h
    for x = 1:w
        clr = squeeze(raster(y, x, :))';
        plot(x, y, '.', 'Color', clr, 'MarkerSize', 15);
    end
end
hold off;

% Drawing shapes (disabled)

function draw(varargin)
    for i = 1:nargin
        V = varargin{i};
        P = V(1:3, :) ./ V(4, :);
        fill3(P(1, :), P(2, :), P(3, :), rand(1, 3), 'FaceAlpha', 0.5);
        hold on;
    end
    grid on;
    %axis equal;
    axis([0 100 0 50]);
    % for az = 0:5:360
    %     view(az, 30)
    %     drawnow
    % end
    view(0, 90)
    hold off;
end
function [r , phi] = cart2polar(x, y)
    r = sqrt (x * x + y * y); % oder : r = norm([x, y])
    phi = atan2(y, x);
end

function [r , phi] = cart2polarVec(v)
    r = sqrt (v(1) * v(1) + v(2) * v(2)); % oder : r = norm(v);
    phi = atan2 (v(2), v(1)) ;
end

function [x , y] = polar2cart(r, phi)
    x = cos(phi) * r;
    y = sin(phi) * r;
end

function v = polar2cartVec(r, phi)
  [x, y] = polar2cart(r, phi);
  v = [x, y];
end

for x = -2:.5:2
    for y = -2:.5:2
        [r, phi] = cart2polar(x, y);
        [x1, y1] = polar2cart(r, phi);
        assert(abs(x1-x) < 1e-9, 'Assertion failed: x is %g, but x1 is %g', x, x1);
        assert(abs(y1-y) < 1e-9, 'Assertion failed: y is %g, but y1 is %g', y, y1);
    end
end

% Relative Kondition von polar2cart:
% Bei einem Kreis bewegt man sich für einen fixen Winkel am schnellsten in
% x-Richtung, wenn man am oberen/unteren Ende ist (analog y-Richtung:
% rechts/links). krel ist also für x bei phi approx 90°/270° und für y bei
% phi approx 0°/180° besonders schlecht.
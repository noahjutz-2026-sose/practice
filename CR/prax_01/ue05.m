function o = scalar_mul(v, w)
    o = zeros(1, length(v));
    for i = 1:length(v)
        o(i) = v(i) * w(i);
    end
end

v1 = [1 2 3];
v2 = [4 5 6];

v3 = scalar_mul(v1, v2);

v4 = v1 .* v2;

v3
v4

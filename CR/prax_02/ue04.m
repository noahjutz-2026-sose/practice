function t = ntaylor(f, x, x0, n)
    t = subs(f, x, x0);
    for i=1:n
        d = diff(f, x, i);
        d = subs(d, x, x0);
        e = d/factorial(i) * (x-x0)^i;
        t = t + e;
    end
end

function t = computeTangent(f, x)
    f1 = diff (f);
    fx = subs(f, x, 0);
    f1x = subs(f1, x, 0);
    t = fx + f1x * x;
end

syms x;
f = sin(x);
t = computeTangent (f, x);
clf;
hold on;
fplot(f);
fplot(t);
xlim([-20 20]);
ylim([-60 60]);

nt = ntaylor(f, x, 0, 40);
fplot(nt);
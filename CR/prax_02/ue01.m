function deltaF = relativeError (f, xs, x )
    fx = f(x);
    deltaF = abs((f(xs) - fx) / fx) ;
end

f1 = @(x) x.^2;
f2 = @(x) x.^2 + 5*x.^3;
f3 = @(x) sin(x);

x = 1;
error1 = 1/100;
xs1 = 1 + error1;
error2 = 1/1000;
xs2 = 1 + error2;

fprintf('Exact relative errors:\n')

for f = {f1, f2, f3} 
    fun = f{1};
    deltaF1 = relativeError(fun, xs1, x);
    deltaF2 = relativeError(fun, xs2, x);
    fprintf('%s: xs1: %.4f, xs2: %.4f\n', func2str(fun), deltaF1, deltaF2);
end

fprintf('Using relative condition:\n')

function kappa = relativeCondition(f)
    syms x;
    f_sym = f(x);
    df_sym = diff(f_sym, x);
    kappa_sym = abs((x * df_sym) / f_sym);
    kappa = matlabFunction(kappa_sym, 'Vars', 'x');
end

for f = {f1, f2, f3}
    fun = f{1};
    kappaFun = relativeCondition(fun);
    k = kappaFun(x);
    fprintf('%s: xs1: %.4f, xs2: %.4f\n', func2str(fun), k * error1, k * error2);
end
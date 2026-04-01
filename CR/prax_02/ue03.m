x=.988:1e-4:1.012;

p = @(x) x.^7 - 7*x.^6 + 21*x.^5 - 35*x.^4 + 35*x.^3 - 21*x.^2 + 7*x - 1;
q = @(x) (x-1).^7;

plot(x, p(x));
hold on;
plot(x, q(x));

% Warum ist p so wackelig?
% q und p sind die gleiche Funktion. krel(x)=(7x)/(x-1).
% Auslöschung: p und q sind um x=1 schlecht konditioniert.
% q ist stabil, weil h^7 mit h<<1 sehr klein ist.
% p ist instabil, weil Fehler nicht gedämpft werden
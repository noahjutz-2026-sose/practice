v = 1:25;
A = zeros(5);
A(:) = v;

% Ersetzen
L = eye(5);
L(4, 1) = -3;
disp("L");
disp(L);

% Skalieren
D = eye(5);
D(2, 2) = 3;
disp("D");
disp(D);

% Vertauschen
P = eye(5);
P = P([1 2 5 4 3], :);
disp("P");
disp(P);

% Frobenius (Mehrfaches ersetzen)
F = eye(5);
F(3:5, 2) = [3 -4 2]';
disp("F");
disp(F);

% 3c) Multiplikation von links: Zeilenweise; von rechts: Spaltenweise

% 3d)

L = eye(5);
L(4, 1) = -4;
disp("L")
disp(L)
disp("L*A")
disp(L*A)

% 3e)

G = eye(5);
G(3:5, 2) = [-3 4 -2]';
disp("G*F")
disp(G*F)
A1 = [2 -1; 1 1];
b1 = [2 4]';

A2 = [1 2; 4 8];
b2a = [1 1]';
b2b = [3 12]';

A3 = [-1 -1 -1; 4 5 3; 2 -10 1; -3 -2 3];
b3 = [-6 29 -35 -20]';

A4 = [2 -1 1 6; 0 3 1 0; -1 -2 1 4];
b4 = [3 -1 -3]';

problems = {
    A1, b1;
    A2, b2a;
    A2, b2b;
    A3, b3;
    A4, b4
};

for i=1:size(problems, 1)
    A=problems{i, 1};
    b=problems{i, 2};
    Ae=[A b];
    fprintf("Problem %d\n", i);
    if rank(A) == rank(Ae)
        s = rref(Ae);
        disp(s);
    end
end
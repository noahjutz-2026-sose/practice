A = [-2 -3 -4 -5
      5  6  7  8];

B = [1 2 3 4
     0 1 0 1];

C = [2  0 0 0
     0 -3 0 0
     0  0 4 0
     0  0 0 5];

e_1 = [1; 0];
e_2 = [0; 1];
v = [0 0 1 0];
w = [0 0 1 0]';

items = {A, B, C, e_1, e_2, v, w};
names = {"A", "B", "C", "e_1", "e_2", "v", "w"};

for i = 1:length(items)
    for j = 1:length(items)
        var1 = items{i};
        var2 = items{j};
        try
            mult = var1 * var2;
            fprintf("%s * %s\n", names{i}, names{j});
        catch
            fprintf("%s * %s FAIL\n", names{i}, names{j});
        end
    end
end

for i = 1:length(items)
    for j = 1:length(items)
        var1 = items{i};
        var2 = items{j};
        try
            add = var1 + var2;
            fprintf("%s + %s\n", names{i}, names{j});
        catch
            fprintf("%s + %s FAIL\n", names{i}, names{j});
        end
    end
end
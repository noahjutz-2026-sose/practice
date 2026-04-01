function s = repr(x, b)
    symbols = ["0", "1", "2", "3", "4", ...
        "5", "6", "7", "8", "9", ...
        "A", "B", "C", "D", "E", "F"];
    if x == 0
        s = "";
        return
    end
    q = floor(x/b);
    r = mod(x,b);

    s = repr(q, b) + symbols(r+1);
end

repr(1000, 16)
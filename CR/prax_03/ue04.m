function [s, c, e, b, m, str] = IEEE754Custom(x, nc, nm)
    bits = false(1, nm);
    i = 1;
    intPart = floor(x);
    while intPart >= 1
        bit = mod(intPart, 2) ~= 0;
        bits(i) = bit;
        i = i + 1;
        intPart = floor(intPart / 2);
    end
    bits(1:i-1) = flip(bits(1:i-1));
    e = i - 1;

    fracPart = sym(x) - floor(sym(x));
    while fracPart > 0 && i <= nm + 1
        fracPart = fracPart * 2;
        bit = fracPart >= 1;
        if ~bits(1) && ~bit
            e = e - 1;
        else
            bits(i) = bit;
            i = i + 1;
        end
        fracPart = fracPart - floor(fracPart);
    end

    bits = bits(2:end);

    b = 2^(nc-1)-1;
    c = e + b;
    m = bits' * 2.^(numel(bits)-1:-1:0);
    s = x < 0;

    str = [s, logical(int2bit(c, nc))', bits];
    str = sprintf('%d', str);


    % str = sprintf('%d', bits);
    % disp(str);
    % disp(e);
end

[s, c, e, b, m, str] = IEEE754Custom(.000000100, 8, 23);

disp(s)
disp(c)
disp(e)
disp(b)
disp(str)

[s, c, e, b, m, str] = IEEE754Custom(700, 10, 100);

function [s, c, m, str] = IEEE754Float(x)
    
end
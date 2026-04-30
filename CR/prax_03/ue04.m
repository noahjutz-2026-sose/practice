function [s, c, m, str] = IEEE754Custom(x, nc, nm)
    bits = false(1, nm);
    i = 1;
    intPart = floor(x);
    while intPart >= 1
        bit = mod(intPart, 2) ~= 0;
        bits(i) = bit;
        intPart = floor(intPart / 2);
        i = i + 1;
    end
    bits(1:i-1) = flip(bits(1:i-1));
    e = i;

    fracPart = sym(x) - floor(sym(x));
    while fracPart > 0 && i < nm
        fracPart = fracPart * 2;
        bit = fracPart >= 1;
        bits(i) = bit;
        fracPart = fracPart - floor(fracPart);
        i = i + 1;
    end
    str = sprintf('%d', bits);
    disp(str);
    disp(e);
end

IEEE754Custom(100.100, 0, 100)

function [s, c, m, str] = IEEE754Float(x)
    
end
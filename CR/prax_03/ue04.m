function [s, c, e, b, m, str] = IEEE754Custom(x, nc, nm)
    bits = false(1, nm + 3);
    i = 1;
    intPart = floor(x);
    while intPart >= 1
        bit = mod(intPart, 2) ~= 0;
        bits(i) = bit;
        i = i + 1;
        intPart = floor(intPart / 2);
    end
    bits(1:i-1) = flip(bits(1:i-1));
    e = i - 2;

    fracPart = sym(x) - floor(sym(x));
    while fracPart > 0 && i <= nm + 3
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

    % Round to even
    if bits(end-1) && (bits(end) || bits(end-2))
        % increment
        for k = numel(bits):-1:1
            if bits(k) == 0
                bits(k) = 1;
                break
            else
                bits(k) = 0;
            end
        end
    end
    bits = bits(2:end-2);

    b = 2^(nc-1)-1;
    c = e + b;
    m = bits' * 2.^(numel(bits)-1:-1:0);
    s = x < 0;

    str = [s, logical(int2bit(c, nc))', bits];
    str = sprintf('%d', str);
end

[s, c, e, b, m, str] = IEEE754Custom(sym('1234.2323'), 8, 23);

% str = insertAfter(str, 9, ' ');
% str = insertAfter(str, 1, ' ');

disp(str)
disp(e)

function [s, c, m, str] = IEEE754Float(x)
    
end
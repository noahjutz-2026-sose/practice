function p = egypt_mult(a, b)
    p = int16(0);
    while (b ~= 0)
        if (bitand(b, 1) == 1)
            p = p + a;
        end
        a = bitshift(a, 1);
        b = bitshift(b, -1);
    end
end

x = egypt_mult(2, 22)
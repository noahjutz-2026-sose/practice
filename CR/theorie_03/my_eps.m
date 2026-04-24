x = single(1+2^(-23));
eps_mach = 1.0;
exponent = 0;
while (x + eps_mach) ~= x
eps_mach = eps_mach / 2;
exponent = exponent - 1;
end
exponent = exponent + 1;
exponent
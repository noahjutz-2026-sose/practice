function min = maxfac()
    min = 0;
    max = realmax;
    while true
        i = floor(mean([min, max]));
        disp(i)
        try
            n = factorial(i);
        catch
            max = i;
            continue;
        end
    
        if max - min <= 1
            break
        end
        if n == inf
            max = i;
        else 
            min = i;
        end
    end
end

function b = binomial(n, k)
    k = min([k, n-k]);
    b = prod(k+1:n) / factorial(n-k);
end

binomial(100, 50);
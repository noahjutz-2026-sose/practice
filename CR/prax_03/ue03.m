function lo = maxinp(fn)
    lo = 0;
    hi = realmax;
    msg = "";
    while true
        mid = floor(lo + (hi - lo) / 2);
        mid = clip(mid, lo, hi);
        fprintf(repmat('\b', 1, length(msg)));
        msg = sprintf('Progress: %-25e %-25e %-25e', lo, hi, abs(lo - hi));
        fprintf('%s', msg);
        try
            n = fn(mid);
        catch ME
            if strcmp(ME.identifier, 'MATLAB:badsubscript')
                n = inf;
            else
                rethrow(ME);
            end
        end
    
        if abs(hi - lo) <= 1
            break
        end
        if isinf(n)
            hi = mid;
        else
            lo = mid;
        end
    end
end

function b = binomial(n, k)
    k = max([k, n-k]);
    b = prod(k+1:n) / factorial(n-k);
end

binomk1 = @(n) binomial(n, 1);

% disp(maxinp(@factorial))
disp(maxinp(binomk1)) % todo too slow
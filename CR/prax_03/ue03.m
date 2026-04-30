function min = maxinp(fn)
    min = 0;
    max = realmax;
    msg = "";
    while true
        i = floor(min + (max - min) / 2);
        i = clip(i, min, max);
        fprintf(repmat('\b', 1, length(msg)));
        msg = sprintf('Progress: %-25e %-25e %-25e', min, max, abs(max - min));
        fprintf('%s', msg);
        try
            n = fn(i);
        catch ME
            if strcmp(ME.identifier, 'MATLAB:badsubscript')
                n = inf; % Only handle out of bounds
            else
                rethrow(ME); % Fail for other errors
            end
        end
    
        if abs(max - min) <= 1
            break
        end
        if isinf(n)
            max = i;
        else
            min = i;
        end
    end
end

function b = binomial(n, k)
    k = max([k, n-k]);
    b = prod(k+1:n) / factorial(n-k);
end

binomk1 = @(n) binomial(n, 1);

binomk1(1000000)

% disp(maxinp(@factorial))
disp(maxinp(@binomk1))
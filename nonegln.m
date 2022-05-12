function [lnx] = nonegln(x)
    %NONEGLN takes the natural log of x and sets to 0 for x < 0
    if x > 0.0
        lnx = reallog(x);
    else
        lnx = 0;
    end
end


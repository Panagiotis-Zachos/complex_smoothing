function [win] = smoothingWindow(win_size, smoothFactor) 
    arguments
        win_size {mustBePositive}
        smoothFactor double {mustBeInRange(smoothFactor, 0, 1)}
    end
    
    factor = 8.0*atan(1)/(win_size-1);
    win = smoothFactor - (1.0-smoothFactor).*cos(factor * (0:win_size-1));
end

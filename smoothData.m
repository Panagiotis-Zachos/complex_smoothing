function out = smoothData(datIn, datLen, winSizes, smoothFactor)
    arguments
        datIn (1,:) {mustBeNumeric}
        datLen (1,1) {mustBePositive}
        winSizes (1,:) {mustBeNumeric}
        smoothFactor double {mustBeInRange(smoothFactor, 0, 1)} = 0.99
    end

    out = zeros(datLen,1);
    for i = 1:datLen
        if ( winSizes(i)>1 )  %% Perform Smoothing if smoothing window length is meaningfull
            smoothWin = smoothingWindow(2*winSizes(i)+1,smoothFactor);
            
            startIdx = i - winSizes(i);
            endIdx = i + winSizes(i);
    
            if startIdx < 1
                smoothWin = smoothWin(-startIdx + 1:end);
                startIdx = 1;
            end
            if endIdx > datLen
                smoothWin = smoothWin(1:end - (endIdx - datLen));
                endIdx = datLen;
            end
            out(i) = sum(datIn(startIdx:endIdx) .* smoothWin)/(2*winSizes(i)+1);
    
        else
            out(i) = datIn(i);
        end  
    end
end
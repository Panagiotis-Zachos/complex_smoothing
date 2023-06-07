function Y = getSpec(imp, fs, nfft)
    if nargin < 3
        nfft = length(imp);
    end
    Y.fourierVec = fft(imp, nfft);
    
    N = floor(length(Y.fourierVec)/2+1);
    yHalfPos = Y.fourierVec(1:N,:);
    Y.mag = abs(yHalfPos);
    Y.phase = angle(yHalfPos);
    Y.dB = db(Y.mag);
    Y.freqVec = linspace(0,fs/2,N)';
end
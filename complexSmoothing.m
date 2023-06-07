function [irSmoothed, specOut] = complexSmoothing(irIn, smoothingMethod, smoothFactor, oct) 

%   Funcion complex_smoothnig
%   created by Panagiotis (Panos) Hatziantoniou
%   updated by Panagiotis Zachos
%   Outputs:  - irSmoothed: Time domain impulse respone after spectral smoothing (samples)
%             - specOut: Smoothed Spectrum (complex samples) 
%   Inputs:   - irIn: Time domain original impulse response (samples)
%             - smoothMethod: Parameter for smoothing method selection. 
%                            'spectrum' : smoothing on spectral magnitude (meter)
%                            'power'       : smoothing on Power spectrum 
%                            'db'    : smoothing on spectral dB scaled magnitude 
%                            'phase'    : smoorthing only on phase 
%                            'complex'  : Complex Smoothing i.e. smoothng on spectral real part 
%                                         and imaginary part       
%                            'mixed'    : Mixed complex smoothing, i.e. building the
%                                         spectrum from smoothing, seperately, the
%                                         magnitude and the phase 
%           - smoothFactor: Defines the shape of the smoothing (averaging)
%                       moving window along the frequency bins. 1 corresponds to a
%                       rectagular window, values < 1 correspond to weighted averaging 
%           - oct: The octave fraction (examples: 1 for 1-octave smothing, 0.33 for 1/3-octave)
%           

arguments
    irIn (1,:) {mustBeNumeric}
    smoothingMethod {mustBeMember(smoothingMethod, {'spectrum', 'power', 'db', 'phase', 'complex', 'mixed'})}
    smoothFactor (1,1) {mustBeNumeric} = 0.99
    oct (1,1) {mustBeNumeric} = 1/6
end

NFFT = 2^nextpow2(length(irIn));

specIn = fft(irIn, NFFT);
phaseIn = phase(specIn);
specOut = complex(zeros(NFFT,1));

Fn = NFFT/2+1;

switch smoothingMethod 
    case 'spectrum'
        temp1=abs(specIn);
        winSizes = PsychoModel(Fn,oct);
        out = smoothData(temp1,Fn,winSizes,smoothFactor);
        specOut(1:Fn) = (out' .* cos(phaseIn(1:Fn))) + 1i .* (out' .*sin(phaseIn(1:Fn)));	

    case 'power'      
        temp1=(abs(specIn)).^2;
        winSizes = PsychoModel(Fn,oct);	
        out = smoothData(temp1,Fn,winSizes,smoothFactor);
        specOut(1:Fn) = (sqrt(out').*cos(phaseIn(1:Fn)))+1i.*(sqrt(out').*sin(phaseIn(1:Fn)));	

    case 'db'
        temp1=20.*log10(abs(specIn));   
        winSizes = PsychoModel(Fn,oct);
        out = smoothData(temp1,Fn,winSizes,smoothFactor);
        specOut(1:Fn) = 10.0.^(out' ./20.0).*cos(phaseIn(1:Fn))+1i*(10.0.^(out'./20.0).*sin(phaseIn(1:Fn)));

    case 'phase'
        temp1=abs(specIn);
        winSizes = PsychoModel(Fn,oct);
        out = smoothData(phaseIn,Fn,winSizes,smoothFactor);
        out = out';
        specOut(1:Fn) = (temp1(1:Fn).*cos(out(1:Fn)))+1i.*(temp1(1:Fn).*sin(out(1:Fn)));   

    case 'complex'
        winSizes = PsychoModel(Fn,oct);
        Rsm = smoothData(real(specIn),Fn,winSizes,smoothFactor);
        Ism = smoothData(imag(specIn),Fn,winSizes,smoothFactor);      
        specOut(1:Fn) = Rsm(1:Fn)+1i.*Ism(1:Fn);              		

    case 'mixed'
        temp1=abs(specIn);
        winSizes = PsychoModel(Fn,oct);
        out = smoothData(temp1,Fn,winSizes,smoothFactor);
        Rsm = smoothData(real(specIn),Fn,winSizes,smoothFactor);
        Ism = smoothData(imag(specIn),Fn,winSizes,smoothFactor);
        specOut(1:Fn) = out(1:Fn).*(cos(phase(Rsm(1:Fn)+1i.*Ism(1:Fn)))+1i.*(sin(phase(Rsm(1:Fn)+1i.*Ism(1:Fn)))));  
end

specOut(Fn+1:NFFT) = flip(real(specOut(2:Fn-1)))+1i.*(-1).*flip(imag(specOut(2:Fn-1)));

irSmoothed = real(ifft(specOut));
   
end  

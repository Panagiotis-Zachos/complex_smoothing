function [win_sizes] = PsychoModel(len, oct)

arguments
    len {mustBePositive}
    oct double {mustBePositive, mustBeLessThan(oct, 1)}
end

larg = (sqrt(2.0)^oct)-(sqrt(0.5)^oct);
win_sizes = round(0.5 * larg * (1:len));
	
end
    
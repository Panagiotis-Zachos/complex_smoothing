clearvars;
clc
SmoothMethod = 'spectrum';
Smfactor = 0.9;
oct = 1/3;


[ir, fs] = audioread('test_data\impulse.wav');

[cs_ir, ~] = complexSmoothing(ir, SmoothMethod, Smfactor, oct);

orig = getSpec(ir, fs);
origS = getSpec(cs_ir, fs);

figure(1)
semilogx(orig.freqVec, orig.dB, 'LineWidth', 2, 'DisplayName', 'Original')
hold on;
semilogx(origS.freqVec, origS.dB, 'LineWidth', 2, 'DisplayName', 'Smoothed')

xlim([10, 1e4])
grid on;
legend('Location', 'Best')

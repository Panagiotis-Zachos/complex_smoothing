# Complex Smoothing
 MATLAB functions that implement different smoothing algorithms

The main function is `complexSmoothing.m` and accepts the following arguments:
 - irIn: Time domain impulse response
 - smoothMethod: Select between the following options
   - `'spectrum'` : smoothing on magnitude spectrum
   - `'power'` : smoothing on power spectrum
   - `'db'` : smoothing on spectral magnitude in dB
   - `'phase'` : smoothing on phase
   - `'complex'` : smoothing on the real and imaginary parts of spectrum
   - `'mixed'` : build the spectrum from smoothing the magnitude and phase separately
 - smoothFactor: Define shape of smoothing window, 1 corresponds to rectangular window, <1 corresponds to weighted averaging
 - oct: The octave fraction (size of window) as a double, 1/3 for 1/3-octave etc.

If you use this code, please cite the following paper:

Hatziantoniou, P. D., & Mourjopoulos, J. N. (2000). Generalized fractional-octave smoothing of audio and acoustic responses. Journal of the Audio Engineering Society, 48(4), 259-280.

## Abstract

A methodology is introduced for smoothing the complex transfer function of measured responses using well-established or arbitrary fractional-octave profiles, based on a novel time-frequency mapping framework. A corresponding impulse response, also derived analytically, has reduced complexity but conforms to perceptual princples. The relationship between complex smoothing and traditional power spectral smoothing is also discussed. 

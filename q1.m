load ps5_data.mat

x = RealWaveform;
f_0 = 30000; % sampling rate of waveform (Hz)
f_stop = 250; % stop frequency (Hz)
f_Nyquist = f_0/2; % the Nyquist limit
n = length(x);
f_all = linspace(-f_Nyquist,f_Nyquist,n);
desired_response = ones(n,1);
desired_response(abs(f_all)<=f_stop) = 0;
x_filtered = real(fftshift(ifft(fft(x.*fftshift(desired_response)))));
plot(x_filtered);
sound(x_filtered*.97/max(abs(x_filtered)),f_0);
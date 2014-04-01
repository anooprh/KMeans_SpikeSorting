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

title('Question 1');
subplot(2,1,1)
plot(x);
xlabel('Time');
ylabel('Voltage');
title('Original Waveform');

subplot(2,1,2)
plot(x_filtered);
xlabel('Time');
ylabel('Voltage');
title('Filtered Waveform');
sound(x_filtered*.97/max(abs(x_filtered)),f_0);
load ps5_data.mat

SAMPLE_LENGTH = 31;
PREV_SAMPLES = 10;

AFTER_SAMPLES = SAMPLE_LENGTH - PREV_SAMPLES - 1;

x = RealWaveform;
f_0 = 30000; % sampling rate of waveform (Hz)
f_stop = 250; % stop frequency (Hz)
f_Nyquist = f_0/2; % the Nyquist limit
n = length(x);
f_all = linspace(-f_Nyquist,f_Nyquist,n);
desired_response = ones(n,1);
desired_response(abs(f_all)<=f_stop) = 0;
x_filtered = real(fftshift(ifft(fft(x.*fftshift(desired_response)))));

subplot(2,1,1);
plot(x_filtered);
hold on
V_th  = ones(size(x_filtered,1),1).*250;
plot(V_th,'r');

x_filtered_shifted = [0; x_filtered(1:size(x_filtered, 1) -1)];
above_th_locs = find((x_filtered > V_th) & (x_filtered_shifted < V_th));
snippets = zeros(SAMPLE_LENGTH, size(above_th_locs, 1));
for i=1:size(above_th_locs,1)
    snippets(:,i) = x_filtered(above_th_locs(i)-PREV_SAMPLES:above_th_locs(i)+AFTER_SAMPLES);
end
save snippets.mat snippets
subplot(2,1,2);
for i=1:size(above_th_locs,1)
    plot(snippets(:,i));
    hold on
end
plot(V_th(1:SAMPLE_LENGTH),'r');
hold on

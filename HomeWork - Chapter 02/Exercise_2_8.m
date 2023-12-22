clear all; close all ; clc;
load("r2112.mat")
%%
sound(rush,FS); %Plays the music
%%
fhat = fft(rush);
PSD = fhat.*conj(fhat)/(length(fhat));
freq = linspace(0,FS, length(fhat));
%%
load("r2112noisy.mat")
%%
sound(rushnoisy,FS);
fhat_n = fft(rushnoisy);
PSD_n = fhat_n.*conj(fhat_n)/(length(fhat_n));
freq_n = linspace(0,FS, length(fhat_n));% Create x-axis of frequencies in Hz 
%%
subplot(4,1,1)
plot(freq, PSD,'r','LineWidth',1.5);hold on;
legend('Original')

subplot(4,1,2)
plot(freq_n, PSD_n, '-b','LineWidth',1.5);
legend('Noisy')
%%
%Plot Spectogram
% Compute and plot the spectrogram
window_size = 1024;
overlap = 512;
[~, frequencies, times, Sxx] = spectrogram(rush, hamming(window_size), overlap, window_size, FS);

subplot(4,1,3)
imagesc(times, frequencies, 10 * log10(abs(Sxx)));
axis xy;
title('Spectrogram');
xlabel('Time (s)');
ylabel('Frequency (Hz)');
colorbar;
colormap('jet');
grid on;
%%
n= length(rushnoisy);
fhat_n = fft(rushnoisy);
fhat_n(n/4:n)=0;
cleansignal=2*real(ifft(fhat_n));
%%
PSD_n = fhat_n.*conj(fhat_n)/(length(fhat_n));
freq_n = linspace(0,FS, length(fhat_n));% Create x-axis of frequencies in Hz 
sound(cleansignal,FS); %Plays the music
subplot(4,1,4)
plot(freq_n, PSD_n, '-b','LineWidth',1.5);
legend('Cleaned Signal')
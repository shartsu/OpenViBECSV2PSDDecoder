function NormalFFT_Periodgram(AveragedEEG, AveragedEEG_Filt_SSVEP, AveragedEEG_Filt_P300, Sampling_Hz)

% === % === % === % === Normal FFT for Averaged EEG === % === % === % === % === 

figure
subplot(1,3,1);
ax = gca; hold all; axis tight; grid on;

X = fft(AveragedEEG);
plot(abs(X));

xlim([0 Sampling_Hz])
set(ax,'XTick',0:10:Sampling_Hz);

hline = refline([0 0]); hline.Color = 'r';

title('{\bf Normal FFT}')
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]')


% === % === % === % === Normal FFT for Filtered 5-27Hz === % === % === % === % === 

subplot(1,3,2);
ax = gca;
hold all;
axis tight;
grid on;

X = fft(AveragedEEG_Filt_SSVEP); 
plot(abs(X));

xlim([0 Sampling_Hz])
set(ax,'XTick',0:10:Sampling_Hz);

hline = refline([0 0]); hline.Color = 'r';

title('{\bf Normal FFT for Filtered 5-27Hz}')
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]')

% === % === % === % === Normal FFT for Filtered 0.1-9Hz === % === % === % === % === 

subplot(1,3,3);
ax = gca; hold all; axis tight; grid on;

Sampling_Hz64 = Sampling_Hz/4; %Check! Downsampled to 1/4

X = fft(AveragedEEG_Filt_P300);
plot(abs(X));

set(ax,'XTick',0:5:Sampling_Hz64);
xlim([0 Sampling_Hz64])

hline = refline([0 0]); hline.Color = 'r';

title('{\bf Normal FFT for Filtered 0.1-9Hz}')
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]')

% === % === % === % === SFFT spectrogram for Averaged EEG === % === % === % === % === 

%{
Fs = Sampling_Hz; % ex. 256
Window = floor(Sampling_Hz * 1.2); % ex. 512 (2 sec under 256Hz) or 307 (1.2 sec)
Overlap = round(Sampling_Hz * 0.3); % ex. 128 (0.5 sec under 256Hz) or 77 (0.3 sec)
%PlotScale = How many plots are needed for a frequency
PlotScale = 10;
Scale = Sampling_Hz * PlotScale; 

figure
spectrogram(AveragedEEG.', Window, Overlap, Scale, Fs);
%}

% === % === % === % === % === % === % === % === % === % === % === % === 
%{
Fs = Sampling_Hz;
N = Signals;
t = 0:1/Fs:1-1/Fs;
xdft = fft(AveragedEEG);
xdft = xdft(1:N/2+1);
psdx = (1/(Fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:Fs/length(AveragedEEG):Fs/2;

figure
plot(freq,10*log10(psdx))
grid on
title('Periodogram Using FFT')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')

%}


% === % === % === % === % === % === % === % === % === % === % === % === 
%{
figure
Fs = Sampling_Hz;             % Sampling frequency
T = 1/Fs;                     % Sample time
L = length(rawEEGSignal);     % Length of signal

NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fft(rawEEGSignal,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);

% Plot single-sided amplitude spectrum.
plot(f,2*abs(Y(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

%}

% === % === % === % === % === % === % === % === % === % === % === % === 

%{
filt = [0.5, 0.5];

figure
N = fft(n);
idx = 1:length(n) / 2 + 1;
[b a] = butter(2, [400 1500]/sr);
y = filter(b, a, n);
Y = fft(y);

subplot(211); plot(f(idx), abs(N(idx)))
subplot(212); plot(f(idx), abs(Y(idx)))
xlabel('Frequency (Hz)')
%}

end
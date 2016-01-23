function Welch(rawEEGSignal, Sampling_Hz)

EEGArray = rawEEGSignal(:, 2:(end-1));

Signals = dot(size(EEGArray(:,1)),[1 0]); %How many plots?

StimulationPoints = length(EEGArray(:,1)); % 6144(6sec) or 12288(12sec) in a file 
StimulationPointsArray = [0, StimulationPoints*1/4, StimulationPoints*2/4, StimulationPoints*3/4];
HowManyFiles = Signals / StimulationPoints;

%X = File1,2,3.... Y=Point1, 2, 3, ... ,7680
for j = 1:HowManyFiles
    for i = 1:StimulationPoints
        AveragedEEG(i, j) = mean(EEGArray(i, :));
    end
end

whos AveragedEEG


% === % === % === % === Filter === % === % === % === % === 

Hd_SSVEP = Filter_SSVEP;
AveragedEEG_Filtered_SSVEP = filter(Hd_SSVEP, AveragedEEG);

AveragedEEG_DownSampled_64Hz = decimate(AveragedEEG, 4);
Fs64 = Sampling_Hz/4;
Hd_P300 = Filter_P300;
AveragedEEG_Filtered_P300 = filter(Hd_P300, AveragedEEG_DownSampled_64Hz);

whos AveragedEEG_Filtered_SSVEP 
whos AveragedEEG_DownSampled_64Hz 
whos AveragedEEG_Filtered_P300

% === % === % === % === Welch for Averaged EEG === % === % === % === % === 

Fs = Sampling_Hz; % ex. 256
Window = floor(Sampling_Hz * 2.0); % ex. 512 (2 sec under 256Hz) or 307 (1.2 sec)
Overlap = round(Sampling_Hz * 0.5); % ex. 128 (0.5 sec under 256Hz) or 77 (0.3 sec)
%PlotScale = How many plots are needed for a frequency
PlotScale = 10;
Scale = Sampling_Hz * PlotScale; 

figure
ax = gca; hold all; axis tight; grid on;
title('Comparison to Welch Averaged PSD for each filtered signals')

%AveragedEEG
[pxx,f] = pwelch(AveragedEEG.', Window, Overlap, Scale, Fs);
plot(f, 10*log10(pxx),'-');

hold on
%AveragedEEG_Filtered_P300
[pxx_SSVEP,f] = pwelch(AveragedEEG_Filtered_SSVEP.', Window, Overlap, Scale, Fs);
plot(f, 10*log10(pxx_SSVEP),'-*');

%AveragedEEG_Filtered_P300
hold on
[pxx_P300,f] = pwelch(AveragedEEG_Filtered_P300.', Window, Overlap, Scale, Fs);
plot(f, 10*log10(pxx_P300),'-x');
hold off

set(ax,'XTick',0:5:256);
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
legend('pxx-Normal', 'pxx-SSVEP(5-27Hz)', 'pxx-P300(64Hz & 0.1-9Hz)') 
xlim([0 256])


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
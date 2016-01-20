function [AveragedEEG, pxx, f] = powerDensity(EEG, Sampling_Hz);

%EEG= importdata(input_CSV);
%whos EEG
%EEG => struct
% -- All datas are in "EEG.data"

%Convert from struct to array

%TimeArray = EEG.data(:,1);
%endPoint  = TimeArray (end,1);

EEGArray = EEG(:, 2:(end-1));
whos EEGArray

ChNum = dot(size(EEGArray(1,:)), [0 1]); %How many channels?
Signals = dot(size(EEGArray(:,1)),[1 0]); %How many plots?

%AveragedEEG = zeros(Signals, 1);

for i = 1:Signals
    AveragedEEG(i, 1) = mean(EEGArray(i, 1:ChNum));
end

whos AveragedEEG

length(AveragedEEG(:,1));
%length(EEG(:,1));

%figure
%plot(EEG(:,1), AveragedEEG.')

%Fs = Sampling_Hz;       % Sampling frequency
%T = 1/Fs;       % Sample time
%L = Signals;    % Length of signal
%t = (0:L-1)*T;  % Time vector

%Welch ===

fs = Sampling_Hz;
%[pxx,f] = pwelch(AveragedEEG.',512,128,256,fs);
[pxx,f] = pwelch(AveragedEEG.',512,128,256*10,fs);

figure
plot(f,10*log10(pxx), '-*')
grid on
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
%xlim([8 24])
ylim([-1 5])

%FFT ===
%http://jp.mathworks.com/help/signal/ug/psd-estimate-using-fft.html
%{
Fs = Sampling_Hz;
N = length(AveragedEEG);
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

%Power ===
%{
fs = Sampling_Hz;
m = length(AveragedEEG);
n = pow2(nextpow2(m));  % Transform length
y = fft(AveragedEEG,n); % DFT
f = (0:n-1)*(fs/n);     % Frequency range
power = y.*conj(y)/n;   % Power of the DFT

f
bar(f,power);
xlabel('Frequency (Hz)')
xlim([5 25])
ylabel('Power')
title('{\bf Periodogram}')
%}

%Power Density ===
%{
figure
Fs = 256;
t = 0:1/Fs:1-1/Fs;
N = length(AveragedEEG);
xdft = fft(AveragedEEG);
xdft = xdft(1:N/2+1);
psdx = (1/(Fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:Fs/length(AveragedEEG):Fs/2;

plot(freq,10*log10(psdx))
grid on
title('Periodogram Using FFT')
xlabel('Frequency (Hz)')
xlim([5 25])
ylabel('Power/Frequency (dB/Hz)')
%}



%NFFT = 2^nextpow2(L); % Next power of 2 from length of y
%Y = fft(AveragedEEG.', NFFT)/L;
%f = Fs/2*linspace(0,1,NFFT/2+1);

%Official example

%{
xdft = fft(AveragedEEG);
xdft = xdft(1:L/2+1);
psdx = (1/(Fs*L)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:Fs/length(AveragedEEG):Fs/2;
plot(freq,10*log10(psdx))
grid on
title('Periodogram Using FFT')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
%}

%pwelch
%[pxx,f] = pwelch(AveragedEEG.',L,300,128,Fs,'centered','power');

%[pxx,f] = pwelch(AveragedEEG.',L,12800,128,Fs);

%plot(f,10*log10(pxx))
%xlabel('Frequency (Hz)')
%ylabel('Magnitude (dB)')


%Sample code on
%http://www.gaussianwaves.com/2014/07/how-to-plot-fft-using-matlab-fft-of-basic-signals-sine-and-cosine-waves/
%{
NFFT=1024;
X=fft(AveragedEEG.',NFFT);	 	 
Px=X.*conj(X)/(NFFT*L); %Power of each freq components	 	 
fVals=Fs*(0:NFFT/2-1)/NFFT;	 	 
plot(fVals,Px(1:NFFT/2),'b','LineWidth',1);	 	 
title('One Sided Power Spectral Density');	 	 
xlabel('Frequency (Hz)')	 	 
ylabel('PSD');
%}
end
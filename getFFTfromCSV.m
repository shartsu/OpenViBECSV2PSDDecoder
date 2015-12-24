function [f, Y, NFFT] = getFFTfromCSV(EEG, Sampling_Hz)

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

AveragedEEG = zeros(Signals, 1);

for i = 1:Signals
    AveragedEEG(i, 1) = mean(EEGArray(i, 9:ChNum));
end

whos AveragedEEG

Fs = Sampling_Hz;       % Sampling frequency
T = 1/Fs;       % Sample time
L = Signals;    % Length of signal
t = (0:L-1)*T;  % Time vector
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fft(AveragedEEG.', NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
end
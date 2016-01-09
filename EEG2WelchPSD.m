function [AveragedEEG, pxx, f] = EEG2WelchPSD(rawEEGSignal, Sampling_Hz);

EEGArray = rawEEGSignal(:, 2:(end-1));

ChNum = dot(size(EEGArray(1,:)), [0 1]); %How many channels?
Signals = dot(size(EEGArray(:,1)),[1 0]); %How many plots?

for i = 1:Signals
    AveragedEEG(i, 1) = mean(EEGArray(i, 1:ChNum));
end

Fs = Sampling_Hz; % ex. 256
Window = Sampling_Hz * 2; % ex. 512 (2 sec under 256Hz)
Overlap = Sampling_Hz / 2; % ex. 128 (0.5 sec under 256Hz)
Scale = Sampling_Hz * 5; %How many plots are need in a frequency

[pxx,f] = pwelch(AveragedEEG.', Window, Overlap, Scale ,Fs);

end
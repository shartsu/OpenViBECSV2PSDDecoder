function [AveragedEEG, pxx1, pxx2, pxx3, pxx4, f] = EEG2WelchPSD_Stimulation4(rawEEGSignal, Sampling_Hz, StimulusDurationSec, PlotFrequencyin1sec)

EEGArray = rawEEGSignal(:, 2:(end-1));

ChNum = dot(size(EEGArray(1,:)), [0 1]); %How many EEG channels?
Signals = dot(size(EEGArray(:,1)),[1 0]); %How many plots?
StimulationPoints = Sampling_Hz * StimulusDurationSec * 4;
StimulationPoints % 7680 in a file 
StimulationPointsArray = [0, StimulationPoints/4, StimulationPoints/3, StimulationPoints/2];
HowManyFiles = Signals / StimulationPoints;

%X = File1,2,3.... Y=Point1, 2, 3, ... ,7680
for j = 1:HowManyFiles
    for i = 1:StimulationPoints
        AveragedEEG(i, j) = mean(EEGArray(i, :));
    end
end

%Mean average of Stimulus 1
for i = 1:(StimulationPoints/4)
    Stimulus1_AveragedEEG(i, 1) = mean(AveragedEEG(StimulationPointsArray(1)+i, 1:HowManyFiles));
    Stimulus2_AveragedEEG(i, 1) = mean(AveragedEEG(StimulationPointsArray(2)+i, 1:HowManyFiles));
    Stimulus3_AveragedEEG(i, 1) = mean(AveragedEEG(StimulationPointsArray(3)+i, 1:HowManyFiles));
    Stimulus4_AveragedEEG(i, 1) = mean(AveragedEEG(StimulationPointsArray(4)+i, 1:HowManyFiles));
end

whos Stimulus1_AveragedEEG
whos Stimulus2_AveragedEEG
whos Stimulus3_AveragedEEG
whos Stimulus4_AveragedEEG

Fs = Sampling_Hz; % ex. 256
Window = Sampling_Hz * 2; % ex. 512 (2 sec under 256Hz)
Overlap = Sampling_Hz / 2; % ex. 128 (0.5 sec under 256Hz)
Scale = Sampling_Hz * PlotFrequencyin1sec; %How many plots are need in a frequency

%pxx1 == 10(*), pxx2 == 15(o), pxx3 == 12(x), pxx4 == 20(+)
[pxx1,f] = pwelch(Stimulus1_AveragedEEG.', Window, Overlap, Scale ,Fs);
[pxx2,f] = pwelch(Stimulus2_AveragedEEG.', Window, Overlap, Scale ,Fs);
[pxx3,f] = pwelch(Stimulus3_AveragedEEG.', Window, Overlap, Scale ,Fs);
[pxx4,f] = pwelch(Stimulus4_AveragedEEG.', Window, Overlap, Scale ,Fs);

end
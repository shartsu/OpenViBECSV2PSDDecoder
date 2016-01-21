function EEG2WelchPSD_Stimulation4(rawEEGSignal, Sampling_Hz)

EEGArray = rawEEGSignal(:, 2:(end-1));

length(EEGArray(:,1))

ChNum = dot(size(EEGArray(1,:)), [0 1]); %How many EEG channels?
Signals = dot(size(EEGArray(:,1)),[1 0]); %How many plots?
%StimulationPoints = Sampling_Hz * StimulusDurationSec * 4;
StimulationPoints = length(EEGArray(:,1)); % 6144(6sec) or 12288(12sec) in a file 
StimulationPointsArray = [0, StimulationPoints/4, StimulationPoints/3, StimulationPoints/2];
HowManyFiles = Signals / StimulationPoints;

%X = File1,2,3.... Y=Point1, 2, 3, ... ,7680
for j = 1:HowManyFiles
    for i = 1:StimulationPoints
        AveragedEEG(i, j) = mean(EEGArray(i, :));
    end
end

%Mean average of All stimuli
for i = 1:(StimulationPoints)
    AllStimuli_AveragedEEG(i, 1) = mean(AveragedEEG(i, 1:HowManyFiles));
end


%Mean average of Stimulus 1 to 4
for i = 1:(StimulationPoints/4)
    Stimulus1_AveragedEEG(i, 1) = mean(AveragedEEG(StimulationPointsArray(1)+i, 1:HowManyFiles));
    Stimulus2_AveragedEEG(i, 1) = mean(AveragedEEG(StimulationPointsArray(2)+i, 1:HowManyFiles));
    Stimulus3_AveragedEEG(i, 1) = mean(AveragedEEG(StimulationPointsArray(3)+i, 1:HowManyFiles));
    Stimulus4_AveragedEEG(i, 1) = mean(AveragedEEG(StimulationPointsArray(4)+i, 1:HowManyFiles));
end

whos AllStimuli_AveragedEEG
whos Stimulus1_AveragedEEG
whos Stimulus2_AveragedEEG
whos Stimulus3_AveragedEEG
whos Stimulus4_AveragedEEG

% === Welch ===

Fs = Sampling_Hz; % ex. 256
Window = floor(Sampling_Hz * 1.2); % ex. 512 (2 sec under 256Hz) or 307 (1.2 sec)
Overlap = round(Sampling_Hz * 0.3); % ex. 128 (0.5 sec under 256Hz) or 77 (0.3 sec)
%PlotScale = How many plots are needed for a frequency
PlotScale = 10;
Scale = Sampling_Hz * PlotScale; 

[pxxAll,f] = pwelch(AllStimuli_AveragedEEG.', Window, Overlap, Scale ,Fs);

%pxx1 == *, pxx2 == o, pxx3 == x, pxx4 == +
[pxx1,f] = pwelch(Stimulus1_AveragedEEG.', Window, Overlap, Scale ,Fs);
[pxx2,f] = pwelch(Stimulus2_AveragedEEG.', Window, Overlap, Scale ,Fs);
[pxx3,f] = pwelch(Stimulus3_AveragedEEG.', Window, Overlap, Scale ,Fs);
[pxx4,f] = pwelch(Stimulus4_AveragedEEG.', Window, Overlap, Scale ,Fs);


% === figure ===
figure
ax = gca;
hold all;
axis tight;
grid on;
plot(f, 10*log10(pxxAll), '-.b');
plot(f, 10*log10(pxx1), '-*', f,10*log10(pxx2), '-o', f,10*log10(pxx3), '-x', f,10*log10(pxx4), '-+')
title('Filtered on OpenViBE')
legend('AllAve', 'Section#1/BoxLeftUp','Section#2/BoxRightUp', 'Section#3/BoxLeftDown', 'Section#4/BoxRightDown');
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
% === X axis ===
set(ax,'XTick',0:1:128);
%xlim([6 22])
% === Y axis ===
set(ax,'YTick',-50:0.5:50);
%ylim([-3 3])

hline = refline([0 0]);
hline.Color = 'r';

end
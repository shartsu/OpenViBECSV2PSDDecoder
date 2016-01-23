function SigViewer_Raw_SSVEP_P300(rawEEGSignal, Sampling_Hz)

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
Sampling_Hz

% === % === % === % === Raw EEG Signal during Trial === % === % === % === % === 

figure
subplot(3,1,1)
ax = gca;
hold all;
axis tight;
grid on;

Fs = Sampling_Hz;
Signal = length(AveragedEEG);
t = (0:1:Signal-1)/Fs;
idx = 1:Signal;

plot(t(idx <= StimulationPointsArray(2)), AveragedEEG(idx <= StimulationPointsArray(2)));
hold on
plot(t(idx > StimulationPointsArray(2) & idx <= StimulationPointsArray(3)),...
    AveragedEEG(idx > StimulationPointsArray(2) & idx <= StimulationPointsArray(3)));
hold on
plot(t(idx > StimulationPointsArray(3) & idx <= StimulationPointsArray(4)),...
    AveragedEEG(idx > StimulationPointsArray(3) & idx <= StimulationPointsArray(4)));
hold on
plot(t(idx > StimulationPointsArray(4)), AveragedEEG(idx > StimulationPointsArray(4)));
hold off

set(ax,'XTick',0:1.5:60);
%set(ax,'YTick',-50:1:50);

hline = refline([0 0]);
hline.Color = 'r';

title('{\bf Raw EEG Signal during Trial}')
xlabel('Time [sec]')
ylabel('Potential [mV]')


% === % === % === % === Raw EEG Signal during Trial for SSVEP (Filtered 5-27) === % === % === % === % === 
% === % === % === % === Filter for SSVEP === % === % === % === % === 
Hd_SSVEP = Filter_SSVEP;
AveragedEEG_Filtered_SSVEP = filter(Hd_SSVEP, AveragedEEG);

subplot(3,1,2)
ax = gca;
hold all;
axis tight;
grid on;

Fs = Sampling_Hz;
Signal = length(AveragedEEG_Filtered_SSVEP);
t = (0:1:Signal-1)/Fs;
idx = 1:Signal;

plot(t(idx <= StimulationPointsArray(2)), AveragedEEG_Filtered_SSVEP(idx <= StimulationPointsArray(2)));
hold on
plot(t(idx > StimulationPointsArray(2) & idx <= StimulationPointsArray(3)),...
    AveragedEEG_Filtered_SSVEP(idx > StimulationPointsArray(2) & idx <= StimulationPointsArray(3)));
hold on
plot(t(idx > StimulationPointsArray(3) & idx <= StimulationPointsArray(4)),...
    AveragedEEG_Filtered_SSVEP(idx > StimulationPointsArray(3) & idx <= StimulationPointsArray(4)));
hold on
plot(t(idx > StimulationPointsArray(4)), AveragedEEG_Filtered_SSVEP(idx > StimulationPointsArray(4)));
hold off

set(ax,'XTick',0:1.5:60);
%set(ax,'YTick',-50:1:50);

hline = refline([0 0]);
hline.Color = 'r';

title('{\bf Raw EEG Signal during Trial for SSVEP (BP Filtered 5Hz-27Hz)}')
xlabel('Time [sec]')
ylabel('Potential [mV]')



% === % === % === % === Raw EEG Signal during Trial for P300 (Filtered 0.1-9) === % === % === % === % === 
% === % === % === % === DownSampling for P300 === % === % === % === % === 
AveragedEEG_DownSampled_64Hz = decimate(AveragedEEG, 4);

whos AverageEEG 
whos AveragedEEG_DownSampled_64Hz

% === % === % === % === Filter for P300 === % === % === % === % === 
Hd_P300 = Filter_P300;
AveragedEEG_Filtered_P300 = filter(Hd_P300, AveragedEEG_DownSampled_64Hz);
whos AveragedEEG_Filtered_P300 

subplot(3,1,3)
ax = gca;
hold all;
axis tight;
grid on;

Fs64 = Sampling_Hz/4; %Check! Downsampled to 1/4
Signal = length(AveragedEEG_Filtered_P300);
t = (0:1:Signal-1)/Fs64;
StimulationPointsArray64 = StimulationPointsArray/4;
idx = 1:Signal;

plot(t(idx <= StimulationPointsArray64(2)), AveragedEEG_Filtered_P300(idx <= StimulationPointsArray64(2)));
hold on
plot(t(idx > StimulationPointsArray64(2) & idx <= StimulationPointsArray(3)/4),...
    AveragedEEG_Filtered_P300(idx > StimulationPointsArray(2)/4 & idx <= StimulationPointsArray64(3)));
hold on
plot(t(idx > StimulationPointsArray64(3) & idx <= StimulationPointsArray(4)/4),...
    AveragedEEG_Filtered_P300(idx > StimulationPointsArray(3)/4 & idx <= StimulationPointsArray64(4)));
hold on
plot(t(idx > StimulationPointsArray64(4)), AveragedEEG_Filtered_P300(idx > StimulationPointsArray64(4)));
hold off

set(ax,'XTick',0:1.5:60);
%set(ax,'YTick',-50:1:50);

hline = refline([0 0]);
hline.Color = 'r';

title('{\bf Raw EEG Signal during Trial for P300 (DownSampled to 64Hz and BP Filtered 0.1Hz-9Hz)}')
xlabel('Time [sec]')
ylabel('Potential [mV]')

end
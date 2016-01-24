function SigViewer_Raw_SSVEP_P300(AveragedEEG, AveragedEEG_Filt_SSVEP, AveragedEEG_Filt_P300_DownSampled_64Hz, StimulationPointsArray, Sampling_Hz)

% === % === % === % === Raw EEG Signal during Trial === % === % === % === % === 
figure
subplot(3,1,1)
ax = gca; 
hold all
axis tight; grid on;
Signal = length(AveragedEEG);
t = (0:1:Signal-1)/Sampling_Hz;
idx = 1:Signal;

plot(t(idx <= StimulationPointsArray(1)), AveragedEEG(idx <= StimulationPointsArray(1)));
hold on
plot(t(idx > StimulationPointsArray(1) & idx <= StimulationPointsArray(2)),...
    AveragedEEG(idx > StimulationPointsArray(1) & idx <= StimulationPointsArray(2)));
hold on
plot(t(idx > StimulationPointsArray(2) & idx <= StimulationPointsArray(3)),...
    AveragedEEG(idx > StimulationPointsArray(2) & idx <= StimulationPointsArray(3)));
hold on
plot(t(idx > StimulationPointsArray(3) & idx <= StimulationPointsArray(4)),...
    AveragedEEG(idx > StimulationPointsArray(3) & idx <= StimulationPointsArray(4)));
hold off

set(ax,'XTick',0:1.5:60);
%set(ax,'YTick',-50:1:50);
hline = refline([0 0]); hline.Color = 'r';

title('{\bf Raw EEG Signal during Trial (1-16Ch, SSVEP+P300)}')
xlabel('Time [sec]')
ylabel('Potential [mV]')


% === % === % === % === Raw EEG Signal during Trial for SSVEP (Filtered 5-27) === % === % === % === % === 
subplot(3,1,2)
ax = gca; 
hold all
axis tight; grid on;
StimulationPointsArray_SSVEP = StimulationPointsArray * 4/5;
CutoffPlots = StimulationPointsArray(1)/5;

whos AveragedEEG_Filt_SSVEP

AveragedEEG_Filt_SSVEP_TimeGap = vertcat(...
    zeros(CutoffPlots, 1), AveragedEEG_Filt_SSVEP(1:StimulationPointsArray_SSVEP(1), 1),...
    zeros(CutoffPlots, 1), AveragedEEG_Filt_SSVEP(StimulationPointsArray_SSVEP(1)+1:StimulationPointsArray_SSVEP(2),1),...
    zeros(CutoffPlots, 1), AveragedEEG_Filt_SSVEP(StimulationPointsArray_SSVEP(2)+1:StimulationPointsArray_SSVEP(3),1),...
    zeros(CutoffPlots, 1), AveragedEEG_Filt_SSVEP(StimulationPointsArray_SSVEP(3)+1:StimulationPointsArray_SSVEP(4),1))

whos AveragedEEG_Filt_SSVEP_TimeGap

plot(t(idx <= StimulationPointsArray(1)), AveragedEEG_Filt_SSVEP_TimeGap(idx <= StimulationPointsArray(1)));
hold on
plot(t(idx > StimulationPointsArray(1) & idx <= StimulationPointsArray(2)),...
    AveragedEEG_Filt_SSVEP_TimeGap(idx > StimulationPointsArray(1) & idx <= StimulationPointsArray(2)));
hold on
plot(t(idx > StimulationPointsArray(2) & idx <= StimulationPointsArray(3)),...
    AveragedEEG_Filt_SSVEP_TimeGap(idx > StimulationPointsArray(2) & idx <= StimulationPointsArray(3)));
hold on
plot(t(idx > StimulationPointsArray(3) & idx <= StimulationPointsArray(4)),...
    AveragedEEG_Filt_SSVEP_TimeGap(idx > StimulationPointsArray(3) & idx <= StimulationPointsArray(4)));
hold off

set(ax,'XTick',0:1.5:60);
%set(ax,'YTick',-50:1:50);
hline = refline([0 0]); hline.Color = 'r';

title('{\bf Raw EEG Signal during Trial for SSVEP (9-16Ch, BP Filtered 5Hz-27Hz)}')
xlabel('Time [sec]')
ylabel('Potential [mV]')

% === % === % === % === Raw EEG Signal during Trial for P300 (Filtered 0.1-9) === % === % === % === % === 
subplot(3,1,3)
ax = gca; 
hold all
axis tight; grid on;

Sampling_Hz64 = Sampling_Hz/4; %Check! Downsampled to 1/4
Signal = length(AveragedEEG_Filt_P300_DownSampled_64Hz);
t64 = (0:1:Signal-1)/Sampling_Hz64;
StimulationPointsArray64 = StimulationPointsArray/4;
idx = 1:Signal;

plot(t64(idx <= StimulationPointsArray64(1)), AveragedEEG_Filt_P300_DownSampled_64Hz(idx <= StimulationPointsArray64(1)));
hold on
plot(t64(idx > StimulationPointsArray64(1) & idx <= StimulationPointsArray64(2)),...
    AveragedEEG_Filt_P300_DownSampled_64Hz(idx > StimulationPointsArray64(1) & idx <= StimulationPointsArray64(2)));
hold on
plot(t64(idx > StimulationPointsArray64(2) & idx <= StimulationPointsArray64(3)),...
    AveragedEEG_Filt_P300_DownSampled_64Hz(idx > StimulationPointsArray64(2) & idx <= StimulationPointsArray64(3)));
hold on
plot(t64(idx > StimulationPointsArray64(3) & idx <= StimulationPointsArray64(4)),...
    AveragedEEG_Filt_P300_DownSampled_64Hz(idx > StimulationPointsArray64(3) & idx <= StimulationPointsArray64(4)));
hold off

set(ax,'XTick',0:1.5:60);
%set(ax,'YTick',-50:1:50);
hline = refline([0 0]); hline.Color = 'r';

title('{\bf Raw EEG Signal during Trial for P300 (1-8Ch, BP Filtered 0.1Hz-9Hz then DownSampled to 64Hz)}')
xlabel('Time [sec]')
ylabel('Potential [mV]')

end
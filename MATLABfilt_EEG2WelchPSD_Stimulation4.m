function MATLABfilt_EEG2WelchPSD_Stimulation4(AveragedEEG_Filt_SSVEP, Sampling_Hz, StimulationPointsArray, StimulusFreqArray)

StimulationPointsArray_SSVEP = StimulationPointsArray * 4/5;
Stimulus1_AveragedEEG = AveragedEEG_Filt_SSVEP(1:StimulationPointsArray_SSVEP(1), 1);
Stimulus2_AveragedEEG = AveragedEEG_Filt_SSVEP(StimulationPointsArray_SSVEP(1)+1:StimulationPointsArray_SSVEP(2), 1);
Stimulus3_AveragedEEG = AveragedEEG_Filt_SSVEP(StimulationPointsArray_SSVEP(2)+1:StimulationPointsArray_SSVEP(3), 1);
Stimulus4_AveragedEEG = AveragedEEG_Filt_SSVEP(StimulationPointsArray_SSVEP(3)+1:StimulationPointsArray_SSVEP(4), 1);

whos Stimulus1_AveragedEEG
whos Stimulus2_AveragedEEG
whos Stimulus3_AveragedEEG
whos Stimulus4_AveragedEEG

% === Filter in MATLAB ===
Hd1 = Filter1;
Hd2 = Filter2;
Hd3 = Filter3;
Hd4 = Filter4;

%
StimulusDuration1_Filter1 = filter(Hd1, Stimulus1_AveragedEEG);
StimulusDuration1_Filter2 = filter(Hd2, Stimulus1_AveragedEEG);
StimulusDuration1_Filter3 = filter(Hd3, Stimulus1_AveragedEEG);
StimulusDuration1_Filter4 = filter(Hd4, Stimulus1_AveragedEEG);

StimulusDuration2_Filter1 = filter(Hd1, Stimulus2_AveragedEEG);
StimulusDuration2_Filter2 = filter(Hd2, Stimulus2_AveragedEEG);
StimulusDuration2_Filter3 = filter(Hd3, Stimulus2_AveragedEEG);
StimulusDuration2_Filter4 = filter(Hd4, Stimulus2_AveragedEEG);

StimulusDuration3_Filter1 = filter(Hd1, Stimulus3_AveragedEEG);
StimulusDuration3_Filter2 = filter(Hd2, Stimulus3_AveragedEEG);
StimulusDuration3_Filter3 = filter(Hd3, Stimulus3_AveragedEEG);
StimulusDuration3_Filter4 = filter(Hd4, Stimulus3_AveragedEEG);

StimulusDuration4_Filter1 = filter(Hd1, Stimulus4_AveragedEEG);
StimulusDuration4_Filter2 = filter(Hd2, Stimulus4_AveragedEEG);
StimulusDuration4_Filter3 = filter(Hd3, Stimulus4_AveragedEEG);
StimulusDuration4_Filter4 = filter(Hd4, Stimulus4_AveragedEEG);

% === Welch ===
Fs = Sampling_Hz; % ex. 256
Window = floor(Sampling_Hz * 2.0); % ex. 512 (2 sec under 256Hz) or 307 (1.2 sec)
Overlap = round(Sampling_Hz * 0.5); % ex. 128 (0.5 sec under 256Hz) or 77 (0.3 sec)
%PlotScale = How many plots are needed for a frequency
PlotScale = 10;
Scale = Sampling_Hz * PlotScale; 

%NonFilter
[pxxAll,f_x100] = pwelch(AveragedEEG_Filt_SSVEP.', Window, Overlap, Scale,Fs);
[pxxD1,f_x100] = pwelch(Stimulus1_AveragedEEG.', Window, Overlap, Scale ,Fs);
[pxxD2,f_x100] = pwelch(Stimulus2_AveragedEEG.', Window, Overlap, Scale ,Fs);
[pxxD3,f_x100] = pwelch(Stimulus3_AveragedEEG.', Window, Overlap, Scale ,Fs);
[pxxD4,f_x100] = pwelch(Stimulus4_AveragedEEG.', Window, Overlap, Scale ,Fs);

Window = floor(Sampling_Hz * 1.2); % ex. 512 (2 sec under 256Hz) or 307 (1.2 sec)
Overlap = round(Sampling_Hz * 0.3); % ex. 128 (0.5 sec under 256Hz) or 77 (0.3 sec)
PlotScale = 1;
Scale = Sampling_Hz * PlotScale; 

%Filter
[pxxD1F1,f] = pwelch(StimulusDuration1_Filter1.', Window, Overlap, Scale ,Fs);
[pxxD2F1,f] = pwelch(StimulusDuration2_Filter1.', Window, Overlap, Scale ,Fs);
[pxxD3F1,f] = pwelch(StimulusDuration3_Filter1.', Window, Overlap, Scale ,Fs);
[pxxD4F1,f] = pwelch(StimulusDuration4_Filter1.', Window, Overlap, Scale ,Fs);

[pxxD1F2,f] = pwelch(StimulusDuration1_Filter2.', Window, Overlap, Scale ,Fs);
[pxxD2F2,f] = pwelch(StimulusDuration2_Filter2.', Window, Overlap, Scale ,Fs);
[pxxD3F2,f] = pwelch(StimulusDuration3_Filter2.', Window, Overlap, Scale ,Fs);
[pxxD4F2,f] = pwelch(StimulusDuration4_Filter2.', Window, Overlap, Scale ,Fs);

[pxxD1F3,f] = pwelch(StimulusDuration1_Filter3.', Window, Overlap, Scale ,Fs);
[pxxD2F3,f] = pwelch(StimulusDuration2_Filter3.', Window, Overlap, Scale ,Fs);
[pxxD3F3,f] = pwelch(StimulusDuration3_Filter3.', Window, Overlap, Scale ,Fs);
[pxxD4F3,f] = pwelch(StimulusDuration4_Filter3.', Window, Overlap, Scale ,Fs);

[pxxD1F4,f] = pwelch(StimulusDuration1_Filter4.', Window, Overlap, Scale ,Fs);
[pxxD2F4,f] = pwelch(StimulusDuration2_Filter4.', Window, Overlap, Scale ,Fs);
[pxxD3F4,f] = pwelch(StimulusDuration3_Filter4.', Window, Overlap, Scale ,Fs);
[pxxD4F4,f] = pwelch(StimulusDuration4_Filter4.', Window, Overlap, Scale ,Fs);


% === % === % === % === % === % === % === % === % === % === % === 
% === figure(All duration welch estimation)===

figure
hold all; ax = gca; axis tight; grid on;

title('All Duration Average Plot (Ch9-16, SSVEP)')
plot(f_x100, 10*log10(pxxAll),'-');

xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
% === X axis ===
set(ax,'XTick',0:5:256);
%xlim([6 22])
% === Y axis ===
%set(ax,'YTick',-50:1:50);
%ylim([-5 5])
hline = refline([0 0]); hline.Color = 'r';

% === figure(Each duration welch estimation)===
figure
hold all; ax = gca; axis tight; grid on;
set(ax,'XTick',0:1:128);
%set(ax,'YTick',-50:0.1:50);

ax1 = subplot(4,1,1);
plot(f_x100, 10*log10(pxxD1),'r-.');
title('Duration 1, Ch9-16'); xlim([6 22]); set(ax1,'XTick',0:1:128); hline = refline([0 0]);

ax2 = subplot(4,1,2);
plot(f_x100, 10*log10(pxxD2),'r-.');
title('Duration 2, Ch9-16'); xlim([6 22]); set(ax2,'XTick',0:1:128); hline = refline([0 0]);

ax3 = subplot(4,1,3);
plot(f_x100, 10*log10(pxxD3),'r-.');
title('Duration 3, Ch9-16'); xlim([6 22]); set(ax3,'XTick',0:1:128); hline = refline([0 0]);

ax4 = subplot(4,1,4);
plot(f_x100, 10*log10(pxxD4),'r-.');
title('Duration 4, Ch9-16'); xlim([6 22]); set(ax4,'XTick',0:1:128); hline = refline([0 0]);

xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')

% === % === % === % === % === % === % === % === % === % === % === 

% === figure(Each Filter)===
% === figure(Subplot1) ===
figure
subplot(2,2,1);
title('Filter 1')
ax = gca; hold all; axis tight; grid on;

plot(f, 10*log10(pxxD1F1), '-*', f,10*log10(pxxD2F1), '-o', f,10*log10(pxxD3F1), '-x', f,10*log10(pxxD4F1), '-+')
legend('Duration1','Duration2', 'Duration3', 'Duration4');
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
% === X axis ===
set(ax,'XTick',0:1:128);
xlim([StimulusFreqArray(1)-1 StimulusFreqArray(1)+1])
% === Y axis ===
%set(ax,'YTick',-50:0.2:50);
%ylim([-5 5])
hline = refline([0 0]); hline.Color = 'r';

% === figure(Subplot2) ===
subplot(2,2,2);
title('Filter 2')
ax = gca; hold all; axis tight; grid on;

plot(f, 10*log10(pxxD1F2), '-*', f,10*log10(pxxD2F2), '-o', f,10*log10(pxxD3F2), '-x', f,10*log10(pxxD4F2), '-+')
legend('Duration1','Duration2', 'Duration3', 'Duration4');
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
% === X axis ===
set(ax,'XTick',0:1:128);
xlim([StimulusFreqArray(2)-1 StimulusFreqArray(2)+1]);
% === Y axis ===
%set(ax,'YTick',-50:0.2:50);
%ylim([-5 5])

hline = refline([0 0]);
hline.Color = 'r';

% === figure(Subplot3) ===
subplot(2,2,3);
title('Filter 3')
ax = gca; hold all; axis tight; grid on;

plot(f, 10*log10(pxxD1F3), '-*', f,10*log10(pxxD2F3), '-o', f,10*log10(pxxD3F3), '-x', f,10*log10(pxxD4F3), '-+')
legend('Duration1','Duration2', 'Duration3', 'Duration4');
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
% === X axis ===
set(ax,'XTick',0:1:128);
xlim([StimulusFreqArray(3)-1 StimulusFreqArray(3)+1]);
% === Y axis ===
%set(ax,'YTick',-50:0.2:50);
%ylim([-5 5])

hline = refline([0 0]); hline.Color = 'r';

% === figure(Subplot4) ===
subplot(2,2,4);
title('Filter 4'); ax = gca; hold all; axis tight; grid on;

plot(f, 10*log10(pxxD1F4), '-*', f,10*log10(pxxD2F4), '-o', f,10*log10(pxxD3F4), '-x', f,10*log10(pxxD4F4), '-+')
legend('Duration1','Duration2', 'Duration3', 'Duration4');
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
% === X axis ===
set(ax,'XTick',0:1:128);
xlim([StimulusFreqArray(4)-1 StimulusFreqArray(4)+1]);
% === Y axis ===
%set(ax,'YTick',-50:0.2:50);
%ylim([-5 5])

hline = refline([0 0]); hline.Color = 'r';

% === % === % === % === % === % === % === % === % === % === % === 

%{

% === figure(Each Stimulus Duration)===
% === figure(Subplot1) ===
figure
subplot(2,2,1);
title('Stimulus Duration 1')
ax = gca;
hold all;
axis tight;
grid on;
plot(f, 10*log10(pxxD1F1), '-*', f,10*log10(pxxD1F2), '-o', f,10*log10(pxxD1F3), '-x', f,10*log10(pxxD1F4), '-+')
legend('BoxLeftUp','BoxRightUp', 'BoxLeftDown', 'BoxRightDown');
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
% === X axis ===
set(ax,'XTick',0:1:128);
xlim([StimulusFreqArray(1)-1 StimulusFreqArray(1)+1])
% === Y axis ===
set(ax,'YTick',-50:1:50);
%ylim([-5 5])

hline = refline([0 0]);
hline.Color = 'r';

% === figure(Subplot2) ===

subplot(2,2,2);
title('Stimulus Duration 2')
ax = gca;
hold all;
axis tight;
grid on;
plot(f, 10*log10(pxxD2F1), '-*', f,10*log10(pxxD2F2), '-o', f,10*log10(pxxD2F3), '-x', f,10*log10(pxxD2F4), '-+')
legend('BoxLeftUp','BoxRightUp', 'BoxLeftDown', 'BoxRightDown');
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
% === X axis ===
set(ax,'XTick',0:1:128);
xlim([StimulusFreqArray(2)-1 StimulusFreqArray(2)+1]);
% === Y axis ===
set(ax,'YTick',-50:1:50);
%ylim([-5 5])

hline = refline([0 0]);
hline.Color = 'r';


% === figure(Subplot3) ===

subplot(2,2,3);
title('Stimulus Duration 3')
ax = gca;
hold all;
axis tight;
grid on;
plot(f, 10*log10(pxxD3F1), '-*', f,10*log10(pxxD3F2), '-o', f,10*log10(pxxD3F3), '-x', f,10*log10(pxxD3F4), '-+')
legend('BoxLeftUp','BoxRightUp', 'BoxLeftDown', 'BoxRightDown');
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
% === X axis ===
set(ax,'XTick',0:1:128);
xlim([StimulusFreqArray(3)-1 StimulusFreqArray(3)+1]);
% === Y axis ===
set(ax,'YTick',-50:1:50);
%ylim([-5 5])

hline = refline([0 0]);
hline.Color = 'r';


% === figure(Subplot4) ===

subplot(2,2,4);
title('Stimulus Duration 4')
ax = gca;
hold all;
axis tight;
grid on;
plot(f, 10*log10(pxxD4F1), '-*', f,10*log10(pxxD4F2), '-o', f,10*log10(pxxD4F3), '-x', f,10*log10(pxxD4F4), '-+')
legend('BoxLeftUp','BoxRightUp', 'BoxLeftDown', 'BoxRightDown');
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
% === X axis ===
set(ax,'XTick',0:1:128);
xlim([StimulusFreqArray(4)-1 StimulusFreqArray(4)+1]);
% === Y axis ===
set(ax,'YTick',-50:1:50);
%ylim([-5 5])

hline = refline([0 0]);
hline.Color = 'r';

%}

end
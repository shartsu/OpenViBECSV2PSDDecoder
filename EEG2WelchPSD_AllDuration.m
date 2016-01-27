function EEG2WelchPSD_AllDuration(AveragedEEG, AveragedEEG_Filt_SSVEP, AveragedEEG_Filt_P300, Sampling_Hz)

% === % === % === % === Welch for Averaged EEG === % === % === % === % === 
Window = floor(Sampling_Hz * 1.0); % ex. 512 (2 sec under 256Hz) or 307 (1.2 sec)
Overlap = round(Sampling_Hz * 0.25); % ex. 128 (0.5 sec under 256Hz) or 77 (0.3 sec)
%PlotScale = How many plots are needed for a frequency
PlotScale = 10;
Scale = Sampling_Hz * PlotScale; 
Sampling_Hz64 = Sampling_Hz/4; %Check! Downsampled to 1/4

figure
ax = gca; hold all; axis tight; grid on;
title('Comparison to Welch Averaged PSD for each filtered signals')

%AveragedEEG
[pxx,f] = pwelch(AveragedEEG.', Window, Overlap, Scale, Sampling_Hz);
plot(f, 10*log10(pxx),'-');

hold on
%AveragedEEG_Filtered_P300
[pxx_SSVEP,f] = pwelch(AveragedEEG_Filt_SSVEP.', Window, Overlap, Scale, Sampling_Hz);
plot(f, 10*log10(pxx_SSVEP),'-*');

%AveragedEEG_Filtered_P300
hold on
[pxx_P300,f] = pwelch(AveragedEEG_Filt_P300.', Window, Overlap, Scale, Sampling_Hz64);
plot(f, 10*log10(pxx_P300),'-x');
hold off

set(ax,'XTick',0:5:256);
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
legend('pxx-Normal(1-16Ch, onlyg.tecFilt)', 'pxx-SSVEP(9-16Ch, BP5-27Hz)', 'pxx-P300(1-8Ch, BP0.1-9Hz, Fs=64Hz)') 
xlim([0 256])

end
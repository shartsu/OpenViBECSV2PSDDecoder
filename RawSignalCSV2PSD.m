function RawSignalCSV2PSD(rawSignalCSVFile, SSVEPStimulusDurationSec, PlotFrequencyin1sec)
 
[rawEEGSignal, Sampling_Hz, Electrodes] = fileProcessor(rawSignalCSVFile);

[AveragedEEG, pxx1, pxx2, pxx3, pxx4, f] = EEG2WelchPSD_Stimulation4(rawEEGSignal, Sampling_Hz, SSVEPStimulusDurationSec, PlotFrequencyin1sec);

figure
ax = gca;
hold all;
axis tight;
grid on;
plot(f,10*log10(pxx1), '-*', f,10*log10(pxx2), '-o', f,10*log10(pxx3), '-x', f,10*log10(pxx4), '-+')
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
% === X axis ===
set(ax,'XTick',0:1:25);
xlim([0 25])
% === Y axis ===
set(ax,'YTick',-5:0.5:10);
ylim([-5 10])

hline = refline([0 0]);
hline.Color = 'r';

end
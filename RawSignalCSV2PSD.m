function RawSignalCSV2PSD(rawSignalCSVFile)
 
[rawEEGSignal, Sampling_Hz, Electrodes] = fileProcessor(rawSignalCSVFile);

[AveragedEEG, pxx, f] = EEG2WelchPSD(rawEEGSignal, Sampling_Hz);

figure
ax = gca;
hold all;
axis tight;
grid on;
plot(f,10*log10(pxx), '-*')
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
% === X axis ===
set(ax,'XTick',8:1:22);
xlim([8 22])
% === Y axis ===
set(ax,'YTick',-2:0.5:5);
ylim([-3 3])
hline = refline([0 0]);
hline.Color = 'r';

end
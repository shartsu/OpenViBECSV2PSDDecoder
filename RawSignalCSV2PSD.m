function RawSignalCSV2PSD(rawSignalCSVFile)
 
[rawEEGSignal, Sampling_Hz, Electrodes] = fileProcessor(rawSignalCSVFile);

[AveragedEEG, pxxAll, pxx1, pxx2, pxx3, pxx4, f] = EEG2WelchPSD_Stimulation4(rawEEGSignal, Sampling_Hz);

figure
ax = gca;
hold all;
axis tight;
grid on;
plot(f, 10*log10(pxxAll), '-.b');
plot(f, 10*log10(pxx1), '-*', f,10*log10(pxx2), '-o', f,10*log10(pxx3), '-x', f,10*log10(pxx4), '-+')
legend('AllAve', 'BoxA(L-Up)','BoxB(R-Up)', 'BoxC(L-Dw)', 'BoxD(R-Dw)');
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
% === X axis ===
set(ax,'XTick',0:1:128);
xlim([8 22])
% === Y axis ===
set(ax,'YTick',-50:0.5:50);
ylim([-10 10])

hline = refline([0 0]);
hline.Color = 'r';

end
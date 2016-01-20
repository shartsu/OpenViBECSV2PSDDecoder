function [PowerSpectrum] = FFTSpectralDataCSV2Graph(fftSpectralDataCSVFile, Sampling_Hz)
 
[fftSpectralData] = fileProcessor(fftSpectralDataCSVFile);

PowerSpectrumSum = 0;

untilEnd_X = (length(fftSpectralData)) / (Sampling_Hz + 1);

DurationPoints_Y = Sampling_Hz + 1; %257
SpectralPoints = [0:0.5:Sampling_Hz/2];
length(SpectralPoints)

for j = 1:(untilEnd_X)
    for i = 1:DurationPoints_Y
        PowerSpectrum(i, j) = fftSpectralData(i+(j-1)*DurationPoints_Y, 2);        
    end
end

for i = 1:DurationPoints_Y
    PowerSpectrumIndex(i, 1) = SpectralPoints (i); %As a X axis scale (0.0, 0.5, 1.0 ~ 128.0)
    PowerSpectrumIndex(i, 2) = sum(PowerSpectrum(i, 2:end));
end

PowerSpectrumSum = sum(PowerSpectrumIndex(:, 2));

for i = 1:DurationPoints_Y
    PowerSpectrumDensity(i, 1) = PowerSpectrumIndex(i, 2) / PowerSpectrumSum;
end

figure
ax = gca;
hold all;
axis tight;
grid on;
bar(SpectralPoints.', PowerSpectrumDensity)

xlabel('Hz', 'FontSize', 10)
ylabel('PSD', 'FontSize', 10)

% === X axis ===
set(ax,'XTick',9:1:21);
xlim([9 21])
% === Y axis ===
%set(ax,'YTick',-0:0.1:1);
%ylim([0 1])

end
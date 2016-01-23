function RawSignalCSV2PSD(rawSignalCSVFile, StimulusFreqArray)
%StimulusFreqArray is set to for instance [7 12 15 20]
 
[rawEEGSignal, Sampling_Hz, Electrodes] = fileProcessor(rawSignalCSVFile);

%EEG2WelchPSD_Stimulation4(rawEEGSignal, Sampling_Hz);
%MATLABfilt_EEG2WelchPSD_Stimulation4(rawEEGSignal, Sampling_Hz, StimulusFreqArray);

SigViewer_Raw_SSVEP_P300(rawEEGSignal, Sampling_Hz);
NormalFFT_Periodgram(rawEEGSignal, Sampling_Hz);
Welch(rawEEGSignal, Sampling_Hz);


% === % === % === % === ChannelCheck === % === % === % === % === 
length(rawEEGSignal)
figure
subplot(8,1,1); plot([1:length(rawEEGSignal)], rawEEGSignal(:,2));
subplot(8,1,2); plot([1:length(rawEEGSignal)], rawEEGSignal(:,3));
subplot(8,1,3); plot([1:length(rawEEGSignal)], rawEEGSignal(:,4));
subplot(8,1,4); plot([1:length(rawEEGSignal)], rawEEGSignal(:,5));
subplot(8,1,5); plot([1:length(rawEEGSignal)], rawEEGSignal(:,6));
subplot(8,1,6); plot([1:length(rawEEGSignal)], rawEEGSignal(:,7));
subplot(8,1,7); plot([1:length(rawEEGSignal)], rawEEGSignal(:,8));
subplot(8,1,8); plot([1:length(rawEEGSignal)], rawEEGSignal(:,9));

end
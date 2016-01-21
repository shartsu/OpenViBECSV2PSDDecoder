function RawSignalCSV2PSD(rawSignalCSVFile, StimulusFreqArray)
%StimulusFreqArray is set to for instance [7 15 12 20]
 
[rawEEGSignal, Sampling_Hz, Electrodes] = fileProcessor(rawSignalCSVFile);

%EEG2WelchPSD_Stimulation4(rawEEGSignal, Sampling_Hz);
MATLABfilt_EEG2WelchPSD_Stimulation4(rawEEGSignal, Sampling_Hz, StimulusFreqArray);




end
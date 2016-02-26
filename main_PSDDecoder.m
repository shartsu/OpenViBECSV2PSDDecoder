function main_PSDDecoder(rawSignalCSVFile, StimulusFreqArray)
%    
% :-:-:-:-:-:-:-:-:-: Up to date INFO :-:-:-:-:-:-:-:-:  
%    
% :-:-:-:-:-:-:-:-:-: Instruction :-:-:-:-:-:-:-:-:-:    
%  
% main_PSDDecoder(ARG_1(char), ARG_2(array));  
%  
% === Input ===    
%    
% ARG_1 rawSignalCSVFile(char): The file which includes signal duration  
% during the experiment, you can choose the file from dialog box if you   
% ARG_2 StimulusFreqArray(char): The list of the frequency of flicker stimulus(ex. [7 15 12 20])  
%  
% === Output ===  
%  
% Figure1: Comparison to Welch Averaged PSD for each filtered signals  
% Figure2: All Duration Average Plot (Ch9-16, SSVEP)  
% Figure3: All duration welch estimation  
% Figure4: Each duration welch estimation  
% Figure5: Raw EEG Signal during Trial for SSVEP, P300 and both  
%  
% === Example ===  
%  
% MATLAB > main_PSDDecoder('../User/DirectoryName/signalfile.csv', [7 15 12 20]);  
% MATLAB > main_PSDDecoder([], [7 15 12 20]);  
%  
% :-:-:-:-: (C) Takumi Kodama, University of Tsukuba, Japan :-:-:-:-:  
 
% === Data exploitation from csv files
[rawEEGSignal, Sampling_Hz, Electrodes, HowManyFiles] = fileProcessor(rawSignalCSVFile);
rawEEGSignalArray = rawEEGSignal(:, 2:(end-1));

% === % === rawEEGSignalArray % === % === 
% ________________| Ch1 | Ch2 | ~~~ | Chi |
% Plot 1          | ... | ... | ... | ... |
% Plot ..         | ... | ... | ... | ... |
% Plot m * FileN  | ... | ... | ... | ... |

StimulationPoints = length(rawEEGSignalArray(:,1)) / HowManyFiles; % 6144(6sec) or 12288(12sec) in a file 
StimulationPointsArray = [StimulationPoints*1/4, StimulationPoints*2/4, StimulationPoints*3/4, StimulationPoints];

% === % === Discriminated EEG Array % === % === 
% ________| mean(File1_AllCh) | ~~~     | mean(FileN_AllCh)
% Plot 1  | ...               | ...     | ...    
% Plot .. | ...               | ...     | ...    
% Plot m  | ...               | ...     | ...    

for j = 1:HowManyFiles
    for i = 1:StimulationPoints
        DiscriminatedEEGArray_16ch(i, j) = mean(rawEEGSignalArray(i+StimulationPoints*(j-1), :));
        DiscriminatedEEGArray_P300(i, j) = mean(rawEEGSignalArray(i+StimulationPoints*(j-1), 1:8));
        DiscriminatedEEGArray_SSVEP(i, j) = mean(rawEEGSignalArray(i+StimulationPoints*(j-1), 9:16));
    end
end

whos DiscriminatedEEGArray_16ch
whos DiscriminatedEEGArray_P300 %Ch1-8
whos DiscriminatedEEGArray_SSVEP %Ch9-16

%Mean average of All stimuli
% === % === Averaged EEG Array % === % === 
% ________| mean(File 1 + File .. + File n) |
% Plot 1  | ...    
% Plot .. | ...    
% Plot m  | ...    

for i = 1:StimulationPoints
    AveragedEEGArray_16ch(i, 1) = mean(DiscriminatedEEGArray_16ch(i, :));
    AveragedEEGArray_SSVEP(i, 1) = mean(DiscriminatedEEGArray_SSVEP(i, :));
    AveragedEEGArray_P300(i, 1) = mean(DiscriminatedEEGArray_P300(i, :));
end

whos AveragedEEGArray_16ch
whos AveragedEEGArray_SSVEP
whos AveragedEEGArray_P300

% === % === % === Signal cut and Filter for SSVEP === % === % === % === % === 
% The beginning of the SSVEP signals, from 0.0 sec to 1.5 or 3.0 sec
% (ex. totally 384 or 768 plots in 256Hz) are cut due to stumulation time gap
%{
CutoffPlots = StimulationPointsArray(1)/5;
Duration1 = AveragedEEGArray_SSVEP(CutoffPlots+1:StimulationPointsArray(1), 1);
Duration2 = AveragedEEGArray_SSVEP(StimulationPointsArray(1)+CutoffPlots+1:StimulationPointsArray(2), 1);
Duration3 = AveragedEEGArray_SSVEP(StimulationPointsArray(2)+CutoffPlots+1:StimulationPointsArray(3), 1);
Duration4 = AveragedEEGArray_SSVEP(StimulationPointsArray(3)+CutoffPlots+1:StimulationPointsArray(4), 1);

AveragedEEGArray_SSVEP_Cut = vertcat(Duration1, Duration2, Duration3, Duration4);
%}

Hd_SSVEP = Filter_SSVEP;
AveragedEEG_Filt_SSVEP = filter(Hd_SSVEP, AveragedEEGArray_SSVEP);

% === % === % === DownSampling and Filter for P300 === % === % === % === % === 
%LPF -> DownSampling
Hd_P300 = Filter_P300;
AveragedEEG_Filt_P300 = filter(Hd_P300, AveragedEEGArray_P300);
AveragedEEG_Filt_P300_DownSampled_64Hz = decimate(AveragedEEG_Filt_P300, 4);

% === % === % === Graph Drawal % === % === % === 

%For figure 1
EEG2WelchPSD_AllDuration(AveragedEEGArray_16ch, AveragedEEG_Filt_SSVEP, AveragedEEG_Filt_P300_DownSampled_64Hz, Sampling_Hz);
%For figure 2, 3 and 4
MATLABfilt_EEG2WelchPSD_Stimulation4(AveragedEEG_Filt_SSVEP, Sampling_Hz, StimulationPointsArray, StimulusFreqArray);
%For figure 5
SigViewer_Raw_SSVEP_P300(AveragedEEGArray_16ch, AveragedEEG_Filt_SSVEP, AveragedEEG_Filt_P300_DownSampled_64Hz, StimulationPointsArray,  Sampling_Hz);
%NormalFFT_Periodgram(AveragedEEGArray, AveragedEEG_Filt_SSVEP, AveragedEEG_Filt_P300_DownSampled_64Hz, Sampling_Hz);

% === % === % === % === ChannelCheck === % === % === % === % === 
%{
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
%}

end
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
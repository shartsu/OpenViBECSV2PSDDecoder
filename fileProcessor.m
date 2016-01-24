function [AllData, Sampling_Hz, Electrodes, HowManyFiles] = fileProcessor(Input_File)

AllData = [];

if isempty(Input_File)
    [FileName, FileNamePath]=uigetfile('*.csv','Select P300 file(s)','multiselect','on');
    FileNameCellArray = strcat(FileNamePath, FileName);
    
    if (ischar(FileNameCellArray))
        HowManyFiles = 1;
        allData_struct = importdata(FileNameCellArray);
        AllData = allData_struct.data;
    else
        HowManyFiles = length(FileNameCellArray);
        for n = 1: length(FileNameCellArray)
            allData_struct = importdata(FileNameCellArray{n});
            AllData = vertcat(AllData, allData_struct.data);
        end
    end    
else
    %For char
    HowManyFiles = 1;
    allData_struct = importdata(Input_File);
    AllData = allData_struct.data;
end

%Sampling heltz data can be get from these data

whos AllData

Sampling_Hz = allData_struct.data(1, end);
Electrodes = allData_struct.textdata(1, 2:(end-1));

end
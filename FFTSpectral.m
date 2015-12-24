function  [PowerDensity] = FFTSpectral(AllData)

Sampling_Hz = 256;

Duration_points = Sampling_Hz + 1;
untilEnd = (length(AllData)) / 257;

for j = 1:untilEnd
    for i = 1:Duration_points
        PowerDensity(i, j) = AllData(i+(j-1)*Duration_points, 2);
    end
end

PowerDensitySum = 0;
for j = 1:size(PowerDensity, 2)
    for i = 1:Duration_points
        PowerDensitySum = PowerDensitySum + PowerDensity(i, j);
    end
end 
whos PowerDensitySum

for j = 1:Sampling_Hz+1
    PowerDensityAverage(j, 1) = mean(PowerDensity(j, end)) / PowerDensitySum;
end

for k = 1: Sampling_Hz+1
    TimeX(1,k) = AllData(k, 3);
end


figure
ax = gca;
hold all;
axis tight;
grid on;
xlim([0 25]);
set(ax,'XTick',0: 0.5: 128);
%set(ax,'YTick',Ymin:1:Ymax);
set(ax,'GridColor',[0 0 1]);

bar(TimeX, PowerDensityAverage);

%title(GraphTitle)
%xlabel('time [s]', 'FontSize', 14)
%ylabel('[\muV]', 'FontSize', 14)

end

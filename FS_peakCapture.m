function [data_peaks] = FS_peakCapture(data)
% get peak times(locations) and height of these peaks

n = 1.0; % maybe could be higher...

for cell = 1:size(data.directed,3)
    % Direcetd Song
    
    Ymean = mean(squeeze(data.directed(:,2:end-5,cell)));
for i = 1:size(data.directed,1)
    
    G = tsmovavg(squeeze(data.directed(i,2:end-5,cell)),'s',3);
    y(i,:) = G(4:end)+abs(min(Ymean));
    
  [pks,locs] = findpeaks(y(i,:),'MinPeakWidth',2,'MinPeakProminence',n*std(y(i,:)));
data_peaks.DirPeaks{cell}{i} = pks;
data_peaks.DirLocs{cell}{i} = locs;
clear pks;
clear locs;
end

[Mpks,Mlocs] = findpeaks(Ymean,'MinPeakWidth',2,'MinPeakProminence',n*std(Ymean));
data_peaks.DirMean(:,cell) = Ymean;
data_peaks.DirMeanPk{cell} = Mpks;
data_peaks.DirMeanLoc{cell} = Mlocs;


% Undirecetd Song
Ymean2 = mean(squeeze(data.undirected(:,2:end-5,cell)));
for i = 1:size(data.undirected,1)
    
    G = tsmovavg(squeeze(data.undirected(i,2:end-5,cell)),'s',3);
    y(i,:) = G(4:end)+abs(min(Ymean));
    plot(y(i,:),'r');
    
  [pks2,locs2] = findpeaks(y(i,:),'MinPeakWidth',2,'MinPeakProminence',n*std(y(i,:)));
data_peaks.UnDirPeaks{cell}{i} = pks2;
data_peaks.UnDirLocs{cell}{i} = locs2;
clear pks;
clear locs;
end
[Mpks,Mlocs] = findpeaks(Ymean2,'MinPeakWidth',2,'MinPeakProminence',n*std(Ymean2));
  data_peaks.UnDirMean(:,cell) = Ymean2;
  data_peaks.UnDirMeanPk{cell} = Mpks;
  data_peaks.UnDirMeanLoc{cell} = Mlocs;
end





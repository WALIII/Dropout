function [data_peaks] = FS_peakCapture(data)
% get peak times(locations) and height of these peaks

n = 1.5; % maybe could be higher...

  figure();
for cell = 1:size(data.directed,3)
    % Direcetd Song
   
    Ymean = mean(squeeze(data.directed(:,:,cell)));
for i = 1:size(data.directed,1)
    
    G = data.directed(i,:,cell);
    y(i,:) = G(1:end)-min(G(1:end));
    
  [pks,locs] = findpeaks(y(i,:),'MinPeakWidth',2,'MinPeakHeight',5);
if cell == 5;
  plot(y(i,:)); hold on; plot(locs,pks,'*');
end;
  data_peaks.DirPeaks{cell}{i} = pks;
data_peaks.DirLocs{cell}{i} = locs;
clear pks;
clear locs;
end

[Mpks,Mlocs] = findpeaks(Ymean,'MinPeakWidth',4,'MinPeakProminence',n*std(Ymean));
data_peaks.DirMean(:,cell) = Ymean;
data_peaks.DirMeanPk{cell} = Mpks;
data_peaks.DirMeanLoc{cell} = Mlocs;


% Undirecetd Song
Ymean2 = mean(squeeze(data.undirected(:,:,cell)));
for i = 1:size(data.undirected,1)
    
    G = data.undirected(i,:,cell);
    y(i,:) = G(1:end)-min(G(1:end));
%     plot(y(i,:),'r');
    
  [pks2,locs2] = findpeaks(y(i,:),'MinPeakWidth',4,'MinPeakHeight',n*std(y(i,:)));
data_peaks.UnDirPeaks{cell}{i} = pks2;
data_peaks.UnDirLocs{cell}{i} = locs2;
clear pks;
clear locs;
end
[Mpks,Mlocs] = findpeaks(Ymean2,'MinPeakWidth',4,'MinPeakProminence',n*std(Ymean2));
  data_peaks.UnDirMean(:,cell) = Ymean2;
  data_peaks.UnDirMeanPk{cell} = Mpks;
  data_peaks.UnDirMeanLoc{cell} = Mlocs;
end





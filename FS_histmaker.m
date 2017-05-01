function  FS_histmaker(data_peaks)

n_CT = 0;
n_CT2 = 0;
nn = 40%size(data_peaks.DirMeanLoc,2); % for each cell,
for i = 1:nn;%size(data_peaks.DirMeanLoc,2);
cell(:,i) = size(data_peaks.DirMeanLoc{i},2); % get number of peaks
end

for ii = 1:nn
for i = 1:size(data_peaks.DirPeaks{1,ii},2); % average across all trials
n_C(:,i) = size(data_peaks.DirPeaks{1,ii}{i},2);

end
avg_C(:,ii) = mean(n_C);
n_CT = horzcat(n_CT,cell(:,ii)-n_C);
clear n_C
end

%Undirected
for i = 1:nn
cell2(:,i) = size(data_peaks.UnDirMeanLoc{i},2); % get number of peaks
end

for ii = 1:nn;%size(data_peaks.UnDirMeanLoc,2); % for each cell,
for i = 1:size(data_peaks.UnDirPeaks{1,ii},2); % average across all trials
n_C2(:,i) = size(data_peaks.UnDirPeaks{1,ii}{i},2);
end
avg_C2(:,ii) = mean(n_C2); % average numper of detected bursts
n_CT2 = horzcat(n_CT2,cell(:,ii)-n_C2);
clear n_C2;
end


G = cell-avg_C;
G2 = cell2-avg_C2;
map = brewermap(2,'Set1');

figure(); 


subplot(131)
histogram(G2,7,'facecolor','m','facealpha',.5)%,'edgecolor','none')
hold on;
histogram(G,7,'facecolor','g','facealpha',.5)%,'edgecolor','none')
legend('undirected','direcetd');
xlabel(' Difference in peak# compared to avg');
ylabel('count (ROI)');

subplot(132)
data = {G2, G};
plotSpread(data, ...
    'xNames', {'undirected', 'direcetd'}, 'distributionColors',{'m','g'}, ...
    'distributionMarkers', {'o', 'o'});
ylim([-3 3]);

ylabel(' Difference in peak# compared to avg');


subplot(133)
histogram(n_CT2,'facecolor','m','facealpha',.5)%,'edgecolor','none')
hold on;
histogram(n_CT,'facecolor','g','facealpha',.5)%,'edgecolor','none')
legend('undirected','direcetd');
xlabel(' Difference in peak# compared to avg');
ylabel('count (ROI)');


figure(); 




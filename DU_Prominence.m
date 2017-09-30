function [stats, amp_data] = DU_Prominence(data)
% DU_Prominence.m

% d09/29/2017
% WAL3

% rank cells based on relative peak amplitude
common = (mean(mean(data.all(:,:,:),3)',2)); % Common signal;

%mean subtract common signal;
X = (mean(data.directed(:,:,:),1));
X2 = squeeze(max(X))
[B(:,1),B(:,2)] = sort(X2,'descend');
% Get measurments 
counter = 1;
counterX = 1;




GG =  B(:,2)';
for i = 1:size(data.directed,1) %trials
for cell = GG
% sum of variance
sVD(:,counter) = sum(abs(((data.directed(i,:,cell)-mean(data.directed(:,:,cell),1)))));% Variance
% Average Variance
mVD(:,counter) = mean(abs(((data.directed(i,:,cell)-mean(data.directed(:,:,cell),1)))));% Variance

% Peak Prominance
try
[pks,locs,w,p] = findpeaks(data.directed(i,:,cell),'MinPeakProminence',2); %MaxPeakWidth'
[mp id] = max(p);

for ii = size(p)
pVD(:,counterX) = max(data.directed(i,:,cell)-min(data.directed(i,:,cell)));
counterX = counterX+1;
end
catch
% ...
end
% Difference in ROI power (Powerdiff)
pdVD(:,counter) = mean(data.directed(i,:,cell),2) -mean(mean(data.all(:,:,cell),1));% Variance

counter = counter+1;
end
end




counterX = 1;
counter = 1;

for i = 1:size(data.undirected,1) %trials
for cell = GG%1:10;
% sum of variance
sVU(:,counter) = sum(abs(((data.undirected(i,:,cell)-mean(data.all(:,:,cell),1)))));% Variance
% Average Variance
mVU(:,counter) = mean(abs(((data.undirected(i,:,cell)-mean(data.all(:,:,cell),1)))));% Variance

% Prominance
try
[pks,locs,w,p] = findpeaks(data.undirected(i,:,cell),'MinPeakProminence',2); %MaxPeakWidth'
[mp id] = max(p);

for ii = size(p)
pVU(:,counterX) = max(data.undirected(i,:,cell)-min(data.undirected(i,:,cell)));
counterX = counterX+1;
end
catch
% ...
end

% Powerdiff
pdVU(:,counter) = mean(data.undirected(i,:,cell),2) -mean(mean(data.all(:,:,cell),1));% Variance

counter = counter+1;
end
end






figure();
hold on;
h2 = histogram(pVU,'FaceColor','m')
h1 = histogram(pVD,'FaceColor','g')
h1.Normalization = 'probability';
h1.BinWidth = 0.75;
h2.Normalization = 'probability';
h2.BinWidth = 0.75;

[~,stats.ROI_all2all] = ttest(pVU(1:1000), pVD(1:1000));
[stats.ROI_all2all_ranksum,~] = ranksum(pVU(1:1000), pVD(1:1000));




% Plot amplitude Differences

    X = (mean(data.directed(:,:,:),1));
    X2 = squeeze(max(X)-min(X))

    DCa = X2;
    
    X = (mean(data.undirected(:,:,:),1));
    X2 = squeeze(max(X)-min(X))
    UCa = X2;
    
    figure();
    title('difference in amp')
    hold on;
    scatter(UCa,DCa);
   x = [0 9];
y = [0 9];
line(x,y,'Color','red','LineStyle','--')

[~,stats.ROI_mean_p] = ttest(UCa, DCa);
[stats.ROI_mean_p_ranksum,~] = ranksum(UCa, DCa);

%Export Data

amp_data.MeanROI(1,:) = DCa;
amp_data.MeanROI(2,:) = UCa;
amp_data.Prom_D = pVD;
amp_data.Prom_U = pVU;



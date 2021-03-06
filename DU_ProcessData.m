function [pooled, stats_amp, amp_data, stats_var, var_data, FINAL] = DU_ProcessData();

% DU_ProcessData.m

% Get stats from all animal in study
%
%   Created: 2017/09/30
%   By: WALIII
%   Updated: 2017/09/30
%   By: WALIII

% get all data in data_dir
DIR=pwd; % Current directroty
mov_listing=dir(fullfile(DIR,'*.mat'));
mov_listing={mov_listing(:).name};
filenames=mov_listing;

for i=1:length(mov_listing)

% load in the data
    warning('off','all')
	load(fullfile(DIR,mov_listing{i}),'calcium','align','Motif_ind');
    warning('on','all')

% Get the right Data
[data] = FS_Data(calcium,align,Motif_ind,5,25);

% Get prominence data
[stats_amp{i} amp_data{i}] = DU_Prominence(data);
% Get Variance data
[stats_var{i} var_data{i}] = DU_Variability(data);

% Pool data
if i == 1 % if the first time in the loop,
pooled.mean_roi = amp_data{i}.MeanROI;
pooled.var_roi = var_data{i}.MeanPearsonScores;
pooled.varCells = var_data{i}.Stat_Difference;
else
pooled.mean_roi = cat(2,pooled.mean_roi,amp_data{i}.MeanROI);% concat data
pooled.var_roi = cat(2,pooled.mean_roi,var_data{i}.MeanPearsonScores);% concat data
pooled.varCells = cat(2,pooled.varCells,var_data{i}.Stat_Difference);
end
clear data;
end

% Bootstrap popultion data
B = 1000;
A1 = FS_bootstrap(pooled.mean_roi(1,:),B);
A2 = FS_bootstrap(pooled.mean_roi(2,:),B);
% take 10,000 bootstrap estimates for the statistic)
[pooled.stats_amp,~] = ranksum(A1(1:10000), A2(1:10000));


B = 1000;
V1 = FS_bootstrap(pooled.var_roi(1,:),B);
V2 = FS_bootstrap(pooled.var_roi(2,:),B);
% take 10,000 bootstrap estimates for the statistic)
[pooled.stats_var,~] = ranksum(V1(1:10000), V2(1:10000));


figure();
XX = pooled.varCells;
X = [sum(double(XX)) size(XX,2)-sum(double(XX))];
 explode = [0 1];
labels = {'variance difference' 'no difference'};
pie(X,explode,labels)
title('Significant variance; p < 1e-5 Wilcox rank-sum ')


% COncat all data
clear combined_amp;

for i = 1:size(mov_listing,1)
    if i ==1;
    combined_amp(1,:) = amp_data{i}.MeanROI(1,:);
    combined_amp(2,:) = amp_data{i}.MeanROI(2,:);
    else
        temp(1,:) = amp_data{i}.MeanROI(1,:);
        temp(2,:) = amp_data{i}.MeanROI(2,:);

        combined_amp = cat(2,combined_amp,temp);
        clear temp
    end
end

FINAL.combined_amp = combined_amp;
% Summary Statistics:

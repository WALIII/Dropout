function [stats] = DU_ProcessData(data);

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
[data] = FS_Data(calcium,align,Motif_ind,1,30);

% Get prominence data
[stats_amp{i} amp_data{i}] = DU_Prominence(data);
% Get Variance data
[stats_var{i} var_data{i}] = DU_Variability(data);

end

% Summary Statistics:





    
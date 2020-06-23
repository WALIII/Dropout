% Quantify ROI displacment in each condition


% Load in data from one bird
% load 'results.m'
load('/Volumes/DATA_01/LIBERTI_DATA/RAW/BIRD/lr28/LR28_re_extract/mat/processed2/results.mat')
% load 'Processed_Data.m
load('/Volumes/DATA_01/LIBERTI_DATA/RAW/BIRD/lr28/LR28_re_extract/mat/processed2/Processed_Data_new.mat')

% 1. Get max projections:

out2 = DU_Compare_MAX(out,metadata);

[out3] = DU_quantify_ROI_jitter(results,out2.max_PNR_directed,out2.max_PNR_undirected);

% Plot everything:
scrap_DU_plotting(out3);
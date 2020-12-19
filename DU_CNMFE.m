function [out,metadata] = DU_CNMFE

homeDir = pwd;
% 1. combine all Mat files
[out,metadata] = DU_Combine_Mat_Files();

processed_FN = ['processed_',datestr(now,'yyyy_mm_dd__hhMM')];

mkdir(processed_FN);
cd(processed_FN);
metadata.processed_FN = pwd;


metadata.moco.itter = 5;
metadata.moco.bin_width = 200;
CNMFe_align(out.mov_data,metadata)

nam = './Motion_corrected_Data.mat'

metadata.cnmfe.min_corr = 0.75;     % minimum local correlation for a seeding pixel
metadata.cnmfe.min_pnr = 2;       % minimum peak-to-noise ratio for a seeding pixel
% 2. Source extraction
CNMFe_extract3(nam,'metadata',metadata);



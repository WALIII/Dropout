function [out,metadata] = DU_CNMFE

homeDir = pwd;
% 1. combine all Mat files
[out,metadata] = DU_Combine_Mat_Files();

mkdir('processed2');
cd('processed2');
metadata.processed_FN = pwd;


metadata.moco.itter = 5;
metadata.moco.bin_width = 200;
CNMFe_align(out.mov_data,metadata)

nam = './Motion_corrected_Data.mat'

metadata.cnmfe.min_corr = 0.8;     % minimum local correlation for a seeding pixel
metadata.cnmfe.min_pnr = 20;       % minimum peak-to-noise ratio for a seeding pixel
% 2. Source extraction
CNMFe_extract2(nam,'metadata',metadata);



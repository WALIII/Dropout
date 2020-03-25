% New Walkthgouh ( in mat directory)

% 1. combine all Mat files
[out,metadata] = DU_Combine_Mat_Files();

mkdir('processed2');
cd('processed2');
metadata.processed_FN = pwd;


metadata.moco.itter = 1;
metadata.moco.bin_width = 200;
CNMFe_align(out.mov_data,metadata)

nam = './Motion_corrected_Data.mat'

metadata.cnmfe.min_corr = 0.8;     % minimum local correlation for a seeding pixel
metadata.cnmfe.min_pnr = 15;       % minimum peak-to-noise ratio for a seeding pixel
% 2. Source extraction
CNMFe_extract2(nam,'metadata',metadata);

% 3. find songs
[song_start, song_end, score_d] = find_audio(out.audio_data, TEMPLATE, 48000, 'match_single', false);

% 4. Align everything
[allVids,start_frame,start_time,aligned] =  DU_Align_Combined(out,song_start,song_end,results);

figure(); for i = 1: 50; plot(squeeze(aligned.C_raw(i,:,:))); pause(); end
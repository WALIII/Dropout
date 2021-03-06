% New Walkthgouh ( in mat directory)

% 1. combine all Mat files
[out,metadata] = DU_Combine_Mat_Files();

mkdir('processed2');
cd('processed2');
metadata.processed_FN = pwd;

% save data
save('mov_data.mat','out','metadata');


% Motion correction
metadata.moco.itter = 1;
metadata.moco.bin_width = 200;
CNMFe_align(out.mov_data,metadata)

nam = './Motion_corrected_Data.mat'

metadata.cnmfe.min_corr = 0.8;     % minimum local correlation for a seeding pixel
metadata.cnmfe.min_pnr = 50;       % minimum peak-to-noise ratio for a seeding pixel
% 2. Source extraction
CNMFe_extract2(nam,'metadata',metadata);

% 3. find songs ( Load Template data)
[out.index.song_start, out.index.song_end, score_d] = find_audio(out.audio_data, TEMPLATE, 48000, 'match_single', false);

% 4. Align everything
[out] =  DU_Align_Combined(out,out.index.song_start,out.index.song_end,results);

% 5. seperate Directed and Undirected; ( Load context index)
out = DU_Check_Directed(out, directed,undirected);
% [out] = DU_assign_directed(out);

% convert to old format:


% COnvert to logical format


% Save data in longical way...



figure(); for i = 1: 50; plot(squeeze(out.aligned.C_raw(i,:,:))); pause(); end
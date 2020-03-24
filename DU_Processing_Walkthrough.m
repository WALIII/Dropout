% New Walkthgouh ( in mat directory)

% 1. combine all Mat files
[out,metadata] = DU_Combine_Mat_Files();

CNMFe_align(out.,metadata)
% 2. Source extraction
CNMFe_extract2(nam,metadata);

% 3. find songs
[song_start, song_end, score_d] = find_audio(out.audio_data, TEMPLATE, 48000, 'match_single', false);

% 4. Align everything
[allVids,start_frame,start_time] =  DU_Align_Combined(out,song_start,song_end,results);
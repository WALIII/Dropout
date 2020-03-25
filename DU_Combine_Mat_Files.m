function [out,metadata] = DU_Combine_Mat_Files();
% index into .mat files, load into one, downsampled movie

% preprocessing for CNMF-E

% d03.23.2020
% WAL3

DIR = pwd;

% input params
save_movie = 0;

% % Make metadata file:
metadata.initial_median_filter_kernal = 3;
metadata.median_filter_kernal = 3;
metadata.artifact_reject =1;
metadata.temp_downsample = 0.25;


%% 1. Get all mat files:

mov_listing=dir(fullfile(DIR,'*.mat'));
mov_listing={mov_listing(:).name};

filenames=mov_listing;

disp('Grabbing .MAT files');

[nblanks formatstring]=fb_progressbar(100);
fprintf(1,['Progress:  ' blanks(nblanks)]);

for i=1:length(mov_listing)
    load(mov_listing{i},'video','audio');
    
    if i ==1;
        % Movie data
        mov_data = imresize(FS_Format(video.frames,1),metadata.temp_downsample);
        mov_time = video.times';
        filename{i} = mov_listing{i};
        idx.movie_idx(i) = size(mov_data,3);
        
        % Audio data
        audio_data = audio.data;
        audio_time = (1:size(audio.data,1))/48000;
        % trim audio
        audio_data(audio_time > max(max(video.times))) = [];
        audio_time(audio_time > max(max(video.times))) = [];
        
        
        idx.audio_idx(i) = size(audio.data,1);
        
    else
        temp_mov = imresize(FS_Format(video.frames,1),metadata.temp_downsample);
        % have to cut audio to fit video:
        temp_audio = audio.data;
        
        temp_audio_time =(1:size(audio.data,1))/48000;
        
        % trim audio
        temp_audio(temp_audio_time > max(max(video.times))) = [];
        temp_audio_time(temp_audio_time > max(max(video.times))) = [];
        
        temp_audio_time =  max(audio_time)+temp_audio_time;
        
        
        
        temp_mov_time = max(mov_time) + video.times';
        
        mov_data = cat(3,mov_data,temp_mov);
        audio_data = cat(1,audio_data,temp_audio);
        
        audio_time = cat(2,audio_time,temp_audio_time);
        mov_time = cat(2,mov_time,temp_mov_time);
        
        %indexing
        idx.audio_idx(i) = size(audio.data,1);
        idx.movie_idx(i) = size(mov_data,3);
        filename{i} = mov_listing{i};
        
    end
    clear video temp_mov temp_mov_time temp_audio_time temp_audio;
    disp(['finished ',mov_listing{i}]);
end


mov_data =  ImBat_denoise(mov_data,'metadata',metadata);

if save_movie ==1;
    FS_tiff(mov_data);
else
end

% Data
out.mov_data = mov_data;
out.audio_data = audio_data;

% Timing
out.audio_time = audio_time;
out.mov_time = mov_time;

% Indexing
out.index = idx;
out.filename = filename;

disp('done');


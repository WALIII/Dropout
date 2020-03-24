function DU_Combine_Mat_Files();
% index into .mat files, load into one, downsampled movie

% preprocessing for CNMF-E

% d03.23.2020
% WAL3

DIR = pwd;

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
    load(mov_listing{i},'video');
    
    if i ==1;
        mov_data = imresize(FS_Format(video.frames,1),metadata.temp_downsample);
    else
        temp = imresize(FS_Format(video.frames,1),metadata.temp_downsample);
        mov_data = cat(3,mov_data,temp);
    end
    clear video;
    disp(['finished ',mov_listing{i}]);
end


mov_data =  ImBat_denoise(mov_data,'metadata',metadata);
FS_tiff(mov_data);
disp('done');


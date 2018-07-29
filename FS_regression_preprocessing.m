function [FS_ROI_Data] = FS_regression_preprocessing()


ogfn = pwd;
% Check to see if directory exists:
fn = 'extraction';
fn2 = 'extraction/processed';
 if exist(fn, 'dir')
   warning('folder exist...')
else
  mkdir(fn)
  mkdir(fn2)


% \\ load TEMPLATE, roi_ave1... roi_ave2...
load('template_data.mat'); % load template data

S = dir(fullfile(pwd,'*.mat')); % load roi data
%
counter = 1;
for k = 1:numel(S)
    N = S(k).name;
    disp(N)
    R = regexp(N,'ave_roi');
    if R ==1;
        filename{counter} = N;
        counter = counter+1;
    end
end

for i = 1:size(filename,2) % run through all roi sets
cd(ogfn)
    load(filename{i})

disp(['loading  ',filename{i}]);
[calcium, DATA_D, song_r, song, align, Motif_ind, BGD, stretch] =  FS_PreMotor(roi_ave,TEMPLATE);



% save data
save(['extraction/',filename{i}(1:end-4),'_extrected.m'],'calcium', 'DATA_D', 'song_r', 'song', 'align', 'Motif_ind', 'BGD', 'stretch','-v7.3');

end

 end


 %%

disp('Processing extracted data...');

cd(fn);
S = dir(fullfile(pwd,'*.mat')); % load roi data


for i = 1:length(S)
  load(S(i).name);
  min_dat = 0;
  max_dat = 35;
[data{i}] = FS_Data(calcium,align,Motif_ind,min_dat,max_dat);

% make a time vector
% Make timevector
tv_calcium = 0:.333:max_dat/30;

% extract song
pad = .25 % seconds
pad_s = pad*48000 % samples

tv_song_r = pad:48000:max_dat/30;
% Song start and end
s_st = ((align/30)*48000)-pad_s;
s_end =  ((align/30)*48000)+ (max_dat/30)*48000 + pad_s;

%to do ( get the song data out!)
data{i}.Motif_ind = Motif_ind;
song_align = (align/30)*48000;
data{i}.song_r = song_r(s_st:s_end,:);
data{i}.song = song;

end


for i = 1:size(data)
  if i == 1;


% concat calcium and song data ( and keep motif data )

%% Data Cleaning


FS_ROI_Data = data;
  end
end

% check song data

% check

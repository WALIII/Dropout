function [FS_ROI_Data] = FS_regression_preprocessing_manual()



% Manually select extreacted file

disp('Select a .mat file');

[fileName2,pathName] = uigetfile('*.mat')

S = load([pathName,fileName2]);
fileName{1} = fileName2;
ogfn = pwd;
% % Check to see if directory exists:
% fn = 'extraction';
% fn2 = 'extraction/processed';
%  if exist(fn, 'dir')
%    warning('folder exist...')
% else
%   mkdir(fn)
%   mkdir(fn2)
%
%
% % \\ load TEMPLATE, roi_ave1... roi_ave2...
% load('template_data.mat'); % load template data
%
% S = dir(fullfile(pwd,'*.mat')); % load roi data
% %
% counter = 1;
% for k = 1:numel(S)
%     N = S(k).name;
%     disp(N)
%     R = regexp(N,'ave_roi');
%     if R ==1;
%         filename{counter} = N;
%         counter = counter+1;
%     end
% end
%
% for i = 1:size(filename,2) % run through all roi sets
% cd(ogfn)
%     load(filename{i})
%
% disp(['loading  ',filename{i}]);
% [calcium, DATA_D, song_r, song, align, Motif_ind, BGD, stretch] =  FS_PreMotor(roi_ave,TEMPLATE);
%
%
%
% % save data
% save(['extraction/',filename{i}(1:end-4),'_extrected.mat'],'calcium', 'DATA_D', 'song_r', 'song', 'align', 'Motif_ind', 'BGD', 'stretch','-v7.3');
%
% end
%
%  end


 %%

disp('Processing extracted data...');

FrameRate = 25;

% cd(fn);
% S = dir(fullfile(pwd,'*.mat')); % load roi data

i = 1;

  min_dat = 0;
  max_dat = 30;

[data{i}] = FS_Data(S.calcium,S.align,S.Motif_ind,min_dat,max_dat);

% make a time vector
% Make timevector
tv_calcium = 0:.333:max_dat/FrameRate;

% extract song
pad = .25; % seconds
pad_s = pad*48000; % samples

tv_song_r = pad:48000:max_dat/FrameRate;
% Song start and end
s_st = ((S.align/FrameRate)*48000)-pad_s;
s_end =  ((S.align/FrameRate)*48000)+ (max_dat/FrameRate)*48000 + pad_s;

%to do ( get the song data out!)
data{i}.Motif_ind = S.Motif_ind;
song_align = (S.align/FrameRate)*48000;
data{i}.song_r = S.song_r(:,s_st:s_end);
data{i}.song = S.song(:,round(s_st/1000):round(s_end/1000));

clear calcium DATA_D song_r song align Motif_ind BGD stretch


for i = 1:size(data,2)
  if i == 1;
D.song = data{i}.song;
D.song_r = data{i}.song_r;
D.unsorted = data{i}.unsorted;
data{i}.Motif_ind(5,:) =  ones(1,size(data{1}.Motif_ind,2))*i;
D.Motif_ind = data{i}.Motif_ind;
D.Motif_ind(5,:);
  else

D.song = cat(1,D.song,data{i}.song);
 D.song_r = cat(1,D.song_r,data{i}.song_r);
 D.unsorted = cat(1,D.unsorted,data{i}.unsorted);
 data{i}.Motif_ind(5,:) =  ones(1,size(data{i}.Motif_ind,2))*i;
 D.Motif_ind = cat(2,D.Motif_ind,data{i}.Motif_ind);
% concat calcium and song data ( and keep motif data )

%% Data Cleaning


  end

end

% extract undirected songs only:
disp('extracting ONLY undirected songs...') % comment out for all songs...
NID = find(D.Motif_ind(3,:) ==0);

D.song = D.song(NID,:);
D.song_r = D.song_r(NID,:);
D.unsorted = D.unsorted(NID,:,:);
D.Motif_ind = D.Motif_ind(:,NID);



D.tv = tv_song_r;
% save('processed/Combined_data.mat','D','-v7.3');




FS_ROI_Data = D;

%% Data Cleaning


% check song data

% check

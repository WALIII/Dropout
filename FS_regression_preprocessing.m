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

for i = 1:size(filename) % run through all roi sets
cd(ogfn)
    load(filename{i})

disp(['loading  ',filename{i}]);
[calcium, DATA_D, song_r, song, align, Motif_ind, BGD, stretch] =  FS_PreMotor(roi_ave,TEMPLATE);

% save data

save(['extraction/',filename{i}(1:end-4),'_extrected.m'],'calcium', 'DATA_D', 'song_r', 'song', 'align', 'Motif_ind', 'BGD', 'stretch');

end

 end

disp('Processing extracted data...');


S = dir(fullfile(pwd,'*.mat')); % load roi data


for i = 1:length(S)
  load(S(i))
[data(:,:,i)] = FS_Data(calcium,align,Motif_ind,0,35);

%to do ( get the song data out!)
data.Motif_ind(:,i) = Motif_ind;
song_align = 30*48000;
data.song_r(:,:,i) = 0;
data.song(:,:,i) = 0;


end



% concat calcium and song data ( and keep motif data )

%% Data Cleaning


FS_ROI_Data = data;
 end

% check song data

% check

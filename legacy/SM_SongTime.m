
function [Times Filenames BoutNo MotifNo Bout_30min] = SM_SongTime(d)
% make a histogram based on when the birdies sing their songs


files = dir(d)
files(1:2) = [] % Exclude parent directories.
dirFlags = [files.isdir]% Get a logical vector that tells which is a directory.
subFolders = files(dirFlags)% Extract only those that are directories.



for i=1:length(subFolders)
    
    cd(subFolders(i).name)
 clear wav_listing;
 clear G;
 clear TimesL:
 
wav_listing=dir(fullfile([pwd,'/new_MANUALCLUST/wav'],'*.wav'));
wav_listing={wav_listing(:).name};

G = wav_listing;
if size(wav_listing) == [0,0]; 
    disp('no songs found...'); 
    G = 0;
    Times{i,1} = 0;
    Times{i,2} = 0;
    MotifNo(i,:) = 0;
    BoutNo(i,:) = 0;
    G2 = 0;
    Bout_30min(i,:) = 0;
    Motif_30min(i,:) = 0;
else
clear G2
TimesL = SRF_DateRead(G);
MotifNo(i,:) = size(TimesL,1);

for ii = 1:size(G,2); G2{ii} = G{ii}(1:end-18); end;
G2 = unique(G2);
TimesR = SRF_DateRead(G2);
BoutNo(i,:) = size(G2,2);
Times{i,1} =  datenum(TimesL); % for motifs
Times{i,2} =  datenum(TimesR); % for bouts

% calculate w/in the last 30 min
V = TimesL(end)
V2 = datenum(V);
d2s    = 24*3600;       % convert from days to seconds
V3 = V2-(60*30)/d2s; % 30 min... this is the last time.
V3 = datetime(V3, 'ConvertFrom', 'datenum')
[ind,~] = find(TimesL(:,1) >= V3);
Bout_30min(i,:) = size(unique(TimesL(ind)),1);
Motif_30min(i,:) = size(ind,1);




end
Filenames{i,1} = G;
Filenames{i,2} = G2;


cd(d);

end



    
    
    
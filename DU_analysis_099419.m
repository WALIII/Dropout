
function DU_analysis_099419



% Go thorugh all files and gather data...

mov_listing=dir(fullfile(pwd,'*.mat'));
mov_listing={mov_listing(:).name};
filenames=mov_listing;


for ii=1:length(mov_listing)
    % cut it out of the datastructure
    
    [path,file,ext]=fileparts(filenames{ii});
    FILE = fullfile(pwd,mov_listing{ii})
    % Load data from each folder
    load(FILE,'calcium','align','Motif_ind');
    
    %song_lengths, for
    if strcmp(file,'LR33_01_06')
        S1 = 0; S2 = 17;
    elseif strcmp(file,'LYY_10_07')
        S1 = 3; S2 = 30;
    elseif strcmp(file,'lr28_02_10')
        S1 = 5; S2 = 27;
    elseif strcmp(file, 'lr5rblk60_12_05')
        S1 = 1; S2 = 25;
    elseif strcmp(file, 'lny39_02_03_ring')
        S1 = 1; S2 = 14;
    elseif strcmp(file, 'lr77_01_24')
        S1 = 1; S2 = 27;
    else
        S1 = 5; S2 = 25;
    end
    
    [data_temp] = FS_Data(calcium,align,Motif_ind,S1,S2);
    
    
    
[pvalD{ii},A1t{ii},A2t{ii},B_sort{ii}, B_unsort{ii}] = DU_PeakSearch(data_temp);
end




for i = 1:6
    if i ==1;
        A1 = A1t{i}(:);
        A2 = A2t{i}(:);
    else
        % concat all data...
        A1 = cat(1,A1,A1t{i}(:));
        A2 = cat(1,A2,A2t{i}(:));
    end
end

[pvalD,HH1] = ranksum((abs(A1)), (abs(A2)))

figure();
hold on;
A1(A1 ==1) = [];
A2(A2 ==1) = [];
histogram(abs(A1(:)),30,'FaceColor','g','Normalization','probability');
histogram(abs(A2(:)),30,'FaceColor','m','Normalization','probability');

figure();
hold on;
A1(A1 ==1) = [];
A2(A2 ==1) = [];
histogram((A1(:)),100,'FaceColor','g','Normalization','probability');
histogram((A2(:)),100,'FaceColor','m','Normalization','probability');


DU_diaganol(B_unsort);

DU_diaganol(B_sort);
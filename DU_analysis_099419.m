
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
    
%     %song_lengths, for
%     if strcmp(file,'LR33_01_06')
%         S1 = 0; S2 = 17;
%     elseif strcmp(file,'LYY_10_07')
%         S1 = 0; S2 = 30;
%     elseif strcmp(file,'lr28_02_10')
%         S1 = 0; S2 = 27;
%     elseif strcmp(file, 'lr5rblk60_12_05')
%         S1 = 0; S2 = 25;
%     elseif strcmp(file, 'lny39_02_03_ring')
%         S1 = 0; S2 = 14;
%     elseif strcmp(file, 'lr77_01_24')
%         S1 = 0; S2 = 30;
%     else
%         S1 = 0; S2 = 25;
%     end
%     
    
        %song_lengths, for
    if strcmp(file,'LR33_01_06')
        S1 = 5; S2 = 17;
    elseif strcmp(file,'LYY_10_07')
        S1 = 3; S2 = 30;
    elseif strcmp(file,'lr28_02_10')
        S1 = 5; S2 = 27;
    elseif strcmp(file, 'lr5rblk60_12_05')
        S1 = 5; S2 = 25;
    elseif strcmp(file, 'lny39_02_03_ring')
        S1 = 1; S2 = 14;
    elseif strcmp(file, 'lr77_01_24')
        S1 = 1; S2 = 30;
    else
        S1 = 5; S2 = 25;
    end
    [data_temp] = FS_Data(calcium,align,Motif_ind,S1,S2);
    
    
    
[pvalD{ii},A1t{ii},A2t{ii},B_sort{ii}, B_unsort{ii},Brand{ii}] = DU_PeakSearch(data_temp);
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

neighborhood = 10;


DU_diaganol(Brand,neighborhood);

for i = 1: 6
    Inp{1} = B_sort{i};
[out] = DU_diaganol(Inp,neighborhood);
Mn(:,i) = out.Mnear;
Mf(:,i) = out.MFar;
end

% Plot the values
figure(); 
hold on;
for i = 1:6;
x = [ 1 2];
y = [Mf(i) Mn(i)];;
plot(x, y, '-k')
hold on
scatter(x(1), y(1), 20, 'b', 'filled')
scatter(x(2), y(2), 20, 'r', 'filled')

axis([0.5  2.5    -.1  .2])
end

DU_diaganol(B_sort,neighborhood);


% Check Directed vs Undirected
% 
% for i = 1: 6
% Inp1{1} = A1t{i};
% Inp2{1} = A2t{i};
% 
% [out1] = DU_diaganol(Inp1,neighborhood);
% Mn1(:,i) = out1.Mnear;
% Mf1(:,i) = out1.MFar;
% 
% [out2] = DU_diaganol(Inp2,neighborhood);
% Mn2(:,i) = out2.Mnear;
% Mf2(:,i) = out2.MFar;
% end
% 

% 
% % Plot the values
% figure(); 
% hold on;
% for i = 1:6;
% x = [1 2];
% y = [Mf1(i) Mf2(i)];;
% plot(x, y, '-k')
% hold on
% scatter(x(1), y(1), 20, 'm', 'filled')
% scatter(x(2), y(2), 20, 'g', 'filled')
% 
% axis([0.5  2.5    -.1  .2])
% end

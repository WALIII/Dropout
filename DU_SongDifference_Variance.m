function DU_SongDifference_Variance(Gconsensus3,D2,cell2use);
% Plot the variance of the audio, in 3 groups, based on the calcium df/f
% 1. Timing/Warping Variance ( across the song)
% 2. Spectral Variance ( similarity score across the song) 
% 3. mean warping and spectral scores, compared to a null distrubition

% input:
% Gconsensus: all concensus contour images
% idmb: sort based on one cell's df/f
% W4 warp vector ( diff of the difference vector)

% WAL3
% d12.02.2019

%------------------------------------------
% Calcultae song difference vector
% Get audio difference vector:
interval = median(diff(D2.warped_time(1,:,1)));
WT = D2.warped_time(:,(1/interval)*0.25:end-(1/interval)*0.5,:);
% Start time at zero:
WT2(1,:,:) = WT(1,:,:)-(WT(1,1,:));
WT2(2,:,:) = WT(2,:,:)-(WT(2,1,:));
% Make difference vector:
WT3 = squeeze(WT2(1,:,:)-WT2(2,:,:));
aVect = (1:size(WT3))*interval;
clear WT2 WT% free up memory
% smooth audio timing vector
[a, b] = size(WT3);
WT3 = zscore(smooth(WT3,200));
WT3 = reshape(WT3,a,b);
WT3 = (WT3);
WT4 = diff(WT3);



% Sort the cell:
% plot from peak to trougth
cs = 1:size(D2.unsorted,1);
Dff_mat = D2.unsorted(cs,:,cell2use)'- min(D2.unsorted(cs,5:end-5,cell2use)');

t1 = floor(cs(end)/3);

% sort by cell's dff
[ma,mb] = max(Dff_mat);
[idma,idmb]  = sort(ma,'descend');


% Define the grouping
dX1 = 1:100;
dX2 = 301:500;
dX3 = 601:700;

%%% Similarity score
% Sort the contours into three groups
S1{1} = Gconsensus3{1}(:,:,idmb(dX1));
S1{2} = Gconsensus3{1}(:,:,idmb(dX2));
S1{3} = Gconsensus3{1}(:,:,idmb(dX3));
S1{4} = Gconsensus3{1}(:,:,randperm(700,400));

G{1} = mean(Gconsensus3{1}(:,:,idmb(dX1)),3);
G{2} = mean(Gconsensus3{1}(:,:,idmb(dX2)),3);
G{3} = mean(Gconsensus3{1}(:,:,idmb(dX3)),3);
G{4} = mean(Gconsensus3{1}(:,:,:),3);%randperm(700,400)),3); % mean of all songs

[r1,r2] = CaBMI_XMASS(G{1},G{2},G{3});
figure(); imagesc(flipud(r1));

% calcultae the similarity scores
for i = 1:4; % 4 is a 'random' assortment
SS1{i} = flipud((S1{i}-G{4})); % full spectrogram
%SS2{i} = (squeeze(sum(SS1{i},1))); % diff vs time
SS2{i} = squeeze(sum(S1{i}-G{4})./std(sum(G{4})));
end

%%% Warping Scores
% Sort the warps into three groups
W1{1} = WT4(:,dX1);
W1{2} = WT4(:,dX2);
W1{3} = WT4(:,dX3);
W1{4} = WT4(:,:);


%%% Plot XMASS image, underlay the Warping and Spectral STD


% %%% Mean Plots
% figure();
% subplot(121);
% hold on; for i = 1:3; plot(smooth(sum(SS2{i}'),10)-smooth(sum(SS2{4}'),10)); end;
% legend('max','med','min');
% title('mean plot');
% subplot(122);
% hold on; for i = 1:3; plot(smooth(std(SS2{i}'),1)-(smooth(std(SS2{4}'),1))); end;
% legend('max','med','min');
% title('mean plot');


% plot with shadding:

 
figure();
subplot(4,1,1);
imagesc(Dff_mat(:,idmb)');
title(['ROI ',num2str(cell2use)]);
subplot(4,1,2)
hold on;
% Plot with shadding
col = hsv(4);

for i = 1:3;
    % take top 10 trials
 
    adata = (SS2{i}-median(SS2{4},2));
[a, b] = size(adata);
adata = (smooth(adata,100));
adata = reshape(adata,a,b);
adata = (adata)';
    % smooth data
    
    
L = size(adata,2);
se = std(adata)/10;%sqrt(length(adata));
mn = median(adata);
 

h = fill([1:L L:-1:1],[mn-se fliplr(mn+se)],col(i,:)); alpha(0.5);
plot(mn,'Color',col(i,:));
 clear adata a b 
end


%%% Warping plots:
subplot(4,1,3)
hold on;
% Plot with shadding
col = hsv(4);

for i = 1:3;
    % take top 10 trials
 
    adata = (W1{i}-mean(W1{4},2));
[a, b] = size(adata);
adata = (smooth(adata,100));
adata = reshape(adata,a,b);
adata = (adata)';
    % smooth data
    
    
L = size(adata,2);
se = std(adata)/10;%sqrt(length(adata));
mn = median(adata);
 

h = fill([1:L L:-1:1],[mn-se fliplr(mn+se)],col(i,:)); alpha(0.5);
plot(mn,'Color',col(i,:));
 
end

subplot(414);

hold on;
plot( abs(zscore(mean(W1{1},2)-mean(W1{3},2))),'g','LineWidth',3);
plot( abs(zscore(smooth(mean(SS2{1},2)-mean(SS2{3},2),50))),'r','LineWidth',3);
legend('Green = warping','Red = spectral');



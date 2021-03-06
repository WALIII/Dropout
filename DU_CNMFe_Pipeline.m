% CNMF-e Directed analysis pipeline


%% Pre-processing:
% For each animal, run:
% 1. FS_AV_Parse
% 2. Create a template song file
% 2. DU_FS_AV_Parse_deploy('cnmfe',1); % will run all days in directory 

% % Batch pre-processing scripts


out = DU_Check_Directed(out, directed,undirected);
%% ROI Analysis 
ind1 = find(out.index.aligned_directed>0);
ind2 = find(out.index.aligned_directed<1);


% randomly subsample:

clear mm1 mm2
mm1 = size(ind1,2)
mm2 = size(ind2,2)

if mm1>mm2
    mm_1 = randi(mm1,1,mm2);
    mm_2 = 1:mm2;
else
    mm_1 = 1:mm1; 
    mm_2 = randi(mm1,1,mm2);
end







% Plot all...
figure(); 
subplot(1,2,1);
hold on;
x = linspace(0,1);
y = linspace(0,1);
plot(x,y);
for i = 1:size(out.aligned.C_raw,1);
plot(max(mean(squeeze(out.aligned.C_raw(i,10:40,ind1(mm_1))),2)),max(mean(squeeze(out.aligned.C_raw(i,10:40,ind2(mm_2))),2)),'*b');
end
for i = 1:size(out.aligned.C_raw,1);
h1 = subplot(1,2,2);

hold on;
plot(squeeze(out.aligned.C_raw(i,:,ind2(mm_2))),'m');
plot(squeeze(out.aligned.C_raw(i,:,ind1(mm_1))),'g');

plot(median(squeeze(out.aligned.C_raw(i,:,ind1(mm_1))),2),'g','LineWidth',3);
plot(median(squeeze(out.aligned.C_raw(i,:,ind2(mm_2))),2),'m','LineWidth',3);
subplot(1,2,1);
plot(max(mean(squeeze(out.aligned.C_raw(i,10:40,ind2(mm_2))),2)),max(mean(squeeze(out.aligned.C_raw(i,10:40,ind1(mm_1))),2)),'*r');

pause();
plot(max(mean(squeeze(out.aligned.C_raw(i,10:40,ind2(mm_2))),2)),max(mean(squeeze(out.aligned.C_raw(i,10:40,ind1(mm_1))),2)),'*b');

cla(h1)
end





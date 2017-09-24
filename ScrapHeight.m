function V = ScrapHeight(calcium,Motif_ind, align,WARPED_TIME,WARPED_audio,Gconsensus)
% Height of data, and plot it

% cell = 1;
range = (align-20:align+30);
prange = ((align):(align+30));
counter1 =1;
counter2 = 1;

disp('calculating song features')
[sim_score, vector_score, A_diff, S_diff, time_score] = FS_PreMotor_FeaturePlot(WARPED_TIME,WARPED_audio,Gconsensus);
%avg Adiff

VV{1} = sum(((A_diff{1})));


for cell = 1:size(calcium,2) % for every cell
% find the peak in the average trace
d = mean(calcium{cell}(:,range),1);
d2 = mean(calcium{cell}(:,prange),1);
Ym = prctile(d2,1);
% [pks,locs] = max(d);
pks = mean(d);

% % figure();
% hold on;
% plot(d);
% plot(locs,pks,'*');

for i = 1:size(calcium{cell},1) % for every trial
    
%     dt = calcium{cell}(i,locs+align-10);
 dt = mean(calcium{cell}(i,range));
    Y = prctile(calcium{cell}(i,prange),1);
    if Motif_ind(3,i) == 0; % undirected
%     valU(:,i) = (dt-Y)-(pks-Ym);
%     valU2(:,i) = NaN;
    vTD(1,counter1) = (dt)/(pks)-1;
    vTD(2,counter1) = cell;
    vTD(3,counter1) = sim_score{1}(i);
    vTD(4,counter1) = time_score{1}(i);
    vTD(5,counter1) = Motif_ind(4,i); % when?
    vTD(6,counter1) = i; % trial
    
    counter1 = counter1+1;
    else
%     valU(:,i) = NaN;
%     valU2(:,i) = (dt-Y)/(pks-Ym);
    vTU(1,counter2) = (dt)/(pks)-1;
    vTU(2,counter2) = cell;
    vTU(3,counter2) = sim_score{1}(i);
    vTU(4,counter2) = time_score{1}(i);
    vTU(5,counter2) = Motif_ind(4,i); % when?
    vTU(6,counter2) = i; % trial
    counter2 = counter2+1;
    end
end
end
% figure();
% subplot(1,2,1)
% hold on;
% plot(valU,'g*');
% plot(valU2,'m*');
% subplot(1,2,2)
% hold on;
figure()
hold on;
h1 = histogram(vTU(1,:));
h2 = histogram(vTD(1,:));
h1.Normalization = 'probability';
h1.BinWidth = 0.1;
h2.Normalization = 'probability';
h2.BinWidth = 0.1;

% legend('Dir', 'Undir')
title( 'Trace Amp difference, compared to avg, for all cells in one bird (Dir = blue)')
ylabel('probability')
xlabel('STD from mean trace')


figure(); 
hold on;
plot(vTU(1,:),'m*')
plot(vTD(1,:),'g*')
 V.D = vTD;
 V.U = vTU;
 
% figure(); 
% hold on;
% plot(V.D(3,:),V.D(1,:),'g*')
% plot(V.U(3,:),V.U(1,:),'m*')
% title('Similarity');
% 
% figure(); 
% hold on;
% plot(V.D(4,:),V.D(1,:),'g*')
% plot(V.U(4,:),V.U(1,:),'m*')
% title('Streatch Needed');

% figure(); 
% subplot(121);
% hold on;
% plot(V.D(5,:),V.D(3,:),'g*')
% plot(V.U(5,:),V.U(3,:),'m*')
% title('Compare Feats');
% subplot(122);
% hold on;
% plot(V.D(5,:),V.D(4,:),'g*')
% plot(V.U(5,:),V.U(4,:),'m*')
% title('Compare Feats');

figure();
title('Ca amp vs time of day')
hold on;
plot(V.D(5,:),V.D(1,:),'m*')
plot(V.U(5,:),V.U(1,:),'g*')
title('Compare Feats');
datetick('x','HH')

figure();
title('Sim_Score v time of day')
hold on;
plot(V.D(5,:),V.D(3,:),'m*')
plot(V.U(5,:),V.U(3,:),'g*')
title('Compare Feats');
datetick('x','HH')

figure();
title('Time Streatch v time of day')
hold on;
plot(V.D(5,:),V.D(4,:),'m*')
plot(V.U(5,:),V.U(4,:),'g*')
title('Compare Feats');
datetick('x','HH')





 

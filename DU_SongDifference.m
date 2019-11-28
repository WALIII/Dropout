
function DU_SongDifference(D2,Gconsensus3,WT3,cell2use)

% plot from peak to trougth
cs = 1:size(D2.unsorted,1);
Dff_mat = D2.unsorted(cs,:,cell2use)'- min(D2.unsorted(cs,5:end-5,cell2use)');

t1 = floor(cs(end)/3);


% make time dff vector

WT4 = diff(WT3);
randp = 0;
figure(); plot(Dff_mat);

[ma,mb] = max(Dff_mat);
[idma,idmb]  = sort(ma,'descend');

figure();
subplot(1,3,1);
imagesc(Dff_mat(:,idmb)');
title('sorted by peak')
subplot(1,3,2);
imagesc(Dff_mat(:,:)');
subplot(1,3,3);
imagesc(D2.song_wds(idmb,:));


title('sorted by time')

if randp ==1;
a = randperm(280);
adX = a(1:t1);
bdX = a(t1*2:t1*3);
else
    adX = 1:50;
    bdX = 230:280;
end


% Gcon by brightest cells 
Ga = mean(Gconsensus3{1}(:,:,idmb(adX)),3);
% Gb = mean(Gconsensus3{1}(:,:,idmb(300:500)),3);
% Gc = mean(Gconsensus3{1}(:,:,idmb(end-100:end)),3);
Gd = mean(Gconsensus3{1}(:,:,idmb(t1:t1*2)),3);
Ge = mean(Gconsensus3{1}(:,:,idmb(bdX)),3);


[r1,r2] = CaBMI_XMASS(Ga,Gd,Ge);
figure(); imagesc(flipud(r1));

G1 = Ga-Gd; % max
G1 = flipud(G1);
%figure(); imagesc(G1,[-300 300]); colormap(fireice);
figure(); imagesc(G1);

G2 = Ge-Gd;
G2 = flipud(G2);


% plot Amplitude and spectral differences:

figure(); 
A1 = mean((WT4(:,idmb(adX)))');
A2 = mean((WT4(:,:))');
A3 = mean((WT4(:,idmb(bdX)))');
hold on;
subplot(131);
hold on;
plot(smooth((sum(G1(:,2:end))),300),'r');
plot(smooth((sum(G2(:,2:end))),300),'b');
subplot(132);
hold on;
plot((A1-A2),'r');
plot((A3-A2),'b');

subplot(133);
hold on;
temp1 = (A1-A2);
temp2 = (A3-A2);
pT1 = zscore(temp1(400:4000));
pT2 = zscore(temp2(400:4000));
plot(pT1(400:4000),'r');
plot(pT2(400:4000),'g');

% pT3 = abs((smooth(sum(G1(:,2:end)),300)-smooth(sum(G2(:,2:end)),300))); 
% plot(pT1,'c');
% plot(pT2(400:4000),'b');

% build distrubution
 out1 = trapz(1:length(pT2),pT2)




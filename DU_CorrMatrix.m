function [stats, output] =  DU_CorrMatrix(data,FIG)
% DU_CorrMatrix.m

% Get correlation matrix from data

% d10/03/2017
% d10/05/2017
% WAL3

if nargin<2
FIG = 1;
end


trialA = 1;
trialB = 1;
% Take the all-to-all pearson corrleation of ROIs
for cell = 1:size(data.directed,3);
GGD = squeeze((data.directed(:,:,cell)'-min(data.directed(:,:,cell)')));
GGU = squeeze((data.undirected(:,:,cell)'-min(data.undirected(:,:,cell)')));
mtxU = corr(GGU);
mtxD = corr(GGD);
% sumU(cell,:) = mtxU(:); % everything is doubled, but thats OK.
% sumD(cell,:) = mtxD(:);
% sM(1,cell) = median(mtxU(:)); % mean for each cell
% sM(2,cell) = median(mtxD(:));
sumU2(cell,:,:) = mtxU(); % everything is doubled, but thats OK.
sumD2(cell,:,:) = mtxD();

end


% How many cells
cells = size(data.undirected,3);

% Take the correlation of each cell across trials
for ii = 1:cells;
GX(:,ii) = squeeze(mean(sumD2(ii,:,:),3));
end

for ii = 1:cells;
GX2(:,ii) = squeeze(median(sumU2(ii,:,:),3));
end

%clean up the data by normalizing to the variance

for(cell=1:cells),
GX(:,cell)=(GX(:,cell)-mean(GX(:,cell)))./std(GX(:,cell));
end

for(cell=1:cells),
GX2(:,cell)=(GX2(:,cell)-mean(GX2(:,cell)))./std(GX2(:,cell));
end


% Sort the data by the directed trials
CVC = cov(GX);
% Sort by mean of both trials





% COV matrix for xcorr and amplitude:
[eig1,eig2,sorting]= FS_cellclust_comp(data);

% Sort by mean...
VV = [GX' GX2']';
CVC=cov(VV);

l = linkage(CVC, 'average', 'correlation');
c=cluster(l,'maxclust',8);
[aa,bb]=sort(c);


CVC_D=cov(GX(:,bb));
CVC_U=cov(GX2(:,bb));
CVC=cov(VV(:,bb));
output.A = CVC_U;
output.B = CVC_D;


if FIG ==1;

 % Plot the cov matrix
clim = [-0.1 0.7];
figure();
subplot(131)
imagesc(CVC_D,clim);
subplot(132)
imagesc(CVC_U,clim);
subplot(133)
imagesc(CVC,clim);
colorbar;


figure();
clim = [-1.5 1.5];
colormap(fireice);
XX1 = CVC_D-CVC_U;

l = linkage(XX1, 'average', 'correlation');
c=cluster(l,'maxclust',3);
[aa,bb]=sort(c);
XX2 = XX1(:,bb);
imagesc(XX2,clim);
title('TEST');



colorbar


figure();
hold on;
h1 = histogram(abs(CVC_U(:)),20,'FaceColor','m');
h2 = histogram(abs(CVC_D(:)),20,'FaceColor','g');
h1.Normalization = 'probability';
h2.Normalization = 'probability';


figure();
hold on;
plot(mean(CVC_U),mean(CVC_D),'o');
plot(zeros(3,1),-1:1,'r--');
plot(-1:1,zeros(3,1),'r--');
plot([0 1], [0 1],'b--');
xlim([-0.5 1]);
ylim([-0.5 1]);

end

output.CVC_U = CVC_U;
output.CVC_U = CVC_D;


%%%%%%%=======================%%%%%%%%
%       Final Figure Plotting        %
%%%%%%%=======================%%%%%%%%


CC = cov(GX);
CC(CC> 0.9) = 0;

[M1 I1] = max(CC); % max of row, and index.

% Sort
[M3 I3] =sort(M1,'descend');

I2 = I3(1);
%[M2 I2] = max(M1)%


Cell1 = I2;
Cell2 = I1(I2);


RHO1 = corr(data.directed(:,:,Cell1)');
RHO2 = corr(data.directed(:,:,Cell2)');
C1 = mean(RHO1);
C2 = mean(RHO2);

RHO3 = corr(data.undirected(:,:,Cell1)');
RHO4 = corr(data.undirected(:,:,Cell2)');
C3 = mean(RHO3);
C4 = mean(RHO4);

figure(); hold on; plot(C1); plot(C2);
figure(); hold on; plot(C3); plot(C4);

% plot offsets
figure();

subplot(121);
hold on;
thresh = 0.4;
for i = 1: size(data.directed,1);
    if C1(i)<thresh;
        HH = 'r';
    else
        HH = 'b';
    end

    plot(squeeze(data.directed(i,:,Cell1)')+i*4,HH);
end
subplot(122)
hold on;
for i = 1:size(data.directed,1);
        if C2(i)<thresh;
        HH = 'r';
    else
        HH = 'b';
    end
    plot(squeeze(data.directed(i,:,Cell2)')+i*4,HH);
end


%--- Plot Undireceted

% plot offsets
figure();

subplot(121);
hold on;
thresh = 0.5;
for i = 1: size(data.undirected,1);
    if C3(i)<thresh;
        HH = 'r';
    else
        HH = 'b';
    end

    plot(squeeze(data.undirected(i,:,Cell1)')+i*4,HH);
end
subplot(122)
hold on;
for i = 1:size(data.undirected,1)
        if C4(i)<thresh;
        HH = 'r';
    else
        HH = 'b';
    end
    plot(squeeze(data.undirected(i,:,Cell2)')+i*4,HH);
end





%% Find latent Factors

Ga = data.directed;
Gb = data.undirected;
for i = 1: 40
   G1= squeeze(Ga(i,:,:))';
   G2= squeeze(Gb(i,:,:))';
[dim_to_use1, result1] = findzdim(G1);
[dim_to_use2, result2] = findzdim(G2);
pool1(:,i) = result1.line;
pool2(:,i) = result2.line;
end

figure(); hold on; plot(pool1,'g'); plot(pool2,'m');



%
% figure();
% subplot(121)
% imagesc(squeeze(data.directed(:,:,1)))
% subplot(122)
% imagesc(squeeze(data.directed(:,:,4)))




% % cell 1;
% figure();
% subplot(121)
% plot(squeeze(data.directed(:,:,Cell1)'));
% title('directed');
% subplot(122)
% plot(squeeze(data.directed(:,:,Cell2)'));
% title('undirected');




stats = 0;

function [stats bb] =  DU_CorrMatrix(data)
% DU_CorrMatrix.m

% Get correlation matrix from data

% d10/03/2017
% d10/05/2017
% WAL3


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
l = linkage(CVC, 'average', 'correlation');
c=cluster(l,'maxclust',10);
[aa,bb]=sort(c);


% COV matrix for xcorr and amplitude:
[eig1,eig2,sorting]= FS_cellclust_comp(data)


bb = sorting;
CVC_D=cov(GX(:,bb));
CVC_U=cov(GX2(:,bb));
% Plot the cov matrix
clim = [-0.2 0.8];
figure();
subplot(121)
imagesc(CVC_D,clim);
subplot(122)
imagesc(CVC_U,clim);
colorbar;


figure(); 
clim = [-1.5 1.5];
colormap(fireice)
XX1 = CVC_D-CVC_U;

imagesc(XX1,clim);





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
stats = 0;

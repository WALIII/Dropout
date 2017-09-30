function [stats] =  DU_Variability(data)
% DU_Variability.m

% Get Variability of calcium data in both ocnditions

% d09/29/2017
% WAL3

% Take the all-to-all pearson corrleation of ROIs
for cell = 1:size(data.directed,3);
GGD = squeeze((data.directed(:,:,cell)'-min(data.directed(:,:,cell)')));
GGU = squeeze((data.undirected(:,:,cell)'-min(data.undirected(:,:,cell)')));
mtxU = corr(GGU);
mtxD = corr(GGD);
sumU(cell,:) = mtxU(:);
sumD(cell,:) = mtxD(:);
sM(1,cell) = median(mtxU(:)); % mean for each cell
sM(2,cell) = median(mtxD(:));
end


% Plot population Histogram
figure();
hold on;
h2 = histogram(sumU(:),'FaceColor','m')
h1 = histogram(sumD(:),'FaceColor','g')
h1.Normalization = 'probability';
h1.BinWidth = 0.1;
h2.Normalization = 'probability';
h2.BinWidth = 0.1;

% Plot mean or ROI opulation as a scatterplot
figure(); scatter(sM(1,:),sM(2,:))
 x = [0 0.8];
 y = [0 0.8];
line(x,y,'Color','red','LineStyle','--')
figure();
histogram(sM(1,:)-sM(2,:));

% figure(); 
% bar(sumU(:),sumD(:))

stats = 0;

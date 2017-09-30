function [stats var_data] =  DU_Variability(data)
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
sumU(cell,:) = mtxU(:); % everything is doubled, but thats OK.
sumD(cell,:) = mtxD(:);
sM(1,cell) = median(mtxU(:)); % mean for each cell
sM(2,cell) = median(mtxD(:));


[~,HH(cell)] = ranksum(mtxU(:), mtxD(:),'alpha', 0.00001*51);

% figure();
% hold on;
% histogram(mtxD(1:1000));
% histogram(mtxU(1:1000));

end
% figure();
% hold on;
% histogram(HH);
% histogram(HH1);
% title('Significant variance (blue p < 0.01*10^(-3)), (red = p<0.05)')

figure();
X = [sum(double(HH)) size(data.directed,3)-sum(double(HH))];
explode = [0 1];
labels = {'variance difference' 'no difference'};
pie(X,explode,labels)
title('Significant variance; p < 1e-5 Wilcox rank-sum ')



% Plot population Histogram
figure();
hold on;
h2 = histogram(sumU(:),'FaceColor','m')
h1 = histogram(sumD(:),'FaceColor','g')
h1.Normalization = 'probability';
h1.BinWidth = 0.1;
h2.Normalization = 'probability';
h2.BinWidth = 0.1;

f = sumU(:);
f2 = sumD(:);
[~,stats.ROI_all2all] = ttest(f(1:10000)', f2(1:10000)');
[stats.ROI_all2all_ranksum,~] = ranksum(f(1:10000)', f2(1:10000)');

% Plot mean or ROI opulation as a scatterplot
figure(); scatter(sM(1,:),sM(2,:))
 x = [0 0.8];
 y = [0 0.8];
line(x,y,'Color','red','LineStyle','--')
figure();
histogram(sM(1,:)-sM(2,:));

[~,stats.ROI_mean_p] = ttest(sM(1,:),sM(2,:));
[stats.ROI_mean_p_ranksum,~] = ranksum(sM(1,:),sM(2,:));


% Export Data
var_data.Stat_Difference = double(HH);
var_data.PearsonScores_D= sumD(:);
var_data.PearsonScores_U = sumU(:);
var_data.MeanPearsonScores = sM;
% figure(); 
% bar(sumU(:),sumD(:))


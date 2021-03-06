function [stats var_data] =  DU_Variability(data)
% DU_Variability.m

% Get Variability of calcium data in both conditions

% d09/29/2017
% WAL3

alphaVal = 0.05./(size(data.directed,3)*2); % significance alpha

trialA = 1;
trialB = 1;
% Take the all-to-all pearson corrleation of ROIs
for cell = 1:size(data.directed,3);
GGD = squeeze((data.directed(:,:,cell)'-min(data.directed(:,:,cell)')));

GGU = squeeze((data.undirected(:,:,cell)'-min(data.undirected(:,:,cell)')));

mtxU = corr(GGU);
mtxD = corr(GGD);
sumU(cell,:) = mtxU(:); % everything is doubled, but thats OK.
sumD(cell,:) = mtxD(:);
sM(1,cell) = mean(mtxU(:)); % mean for each cell
sM(2,cell) = mean(mtxD(:));


% to check distributions:
%figure(); hold on; histogram(mtxU(:),20,'FaceColor','m','Normalization','probability'); histogram(mtxD(:),20,'FaceColor','g','Normalization','probability');
[~,HH(1,cell)] = ranksum(mtxU(:), mtxD(:),'alpha', alphaVal,'tail','left');
[~,HH(2,cell)] = ranksum(mtxU(:), mtxD(:),'alpha', alphaVal,'tail','right');

if HH(1,cell)
    U_seg(trialA,:) = mtxU(:);
    D_seg(trialA,:) = mtxD(:);
    trialA = trialA+1;
else
    U_seg2(trialB,:) = mtxU(:);
    D_seg2(trialB,:) = mtxD(:);
    trialB = trialB+1;
end


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


% figure();
% X = [sum(double(HH)) size(data.directed,3)-sum(double(HH))];
% explode = [0 1];
% labels = {'variance difference' 'no difference'};
% pie(X,explode,labels)
% title('Significant variance; p < 1e-5 Wilcox rank-sum ')


% % %%+++++ FIGURE 02 +++++++%%
% Plot population Histogram
try
figure();

subplot(121)
hold on;
h2 = histogram(U_seg(:),'FaceColor','m');
h1 = histogram(D_seg(:),'FaceColor','g');
h1.Normalization = 'probability';
h1.BinWidth = 0.1;
h2.Normalization = 'probability';
h2.BinWidth = 0.1;

subplot(122)
hold on;
h2 = histogram(U_seg2(:),'FaceColor','m');
h1 = histogram(D_seg2(:),'FaceColor','g');
h1.Normalization = 'probability';
h1.BinWidth = 0.1;
h2.Normalization = 'probability';
h2.BinWidth = 0.1;
catch
    disp('error...');
end

%% % %%+++++ FIGURE 03 +++++++%%
% FS_plotCDF(sumU(:),sumD(:))
%
f = sumU(:);
f2 = sumD(:);
% [~,stats.ROI_all2all] = ttest(f(1:10000)', f2(1:10000)');
[stats.ROI_all2all_ranksum,~] = ranksum(f(:)', f2(:)')



%  %%+++++ FIGURE 04 +++++++%%
% Plot mean or ROI poulation as a scatterplot
figure(); scatter(sM(1,:),sM(2,:))
 x = [0 1];
 y = [0 1];
line(x,y,'Color','red','LineStyle','--')

xlim([ 0 1]);
ylim([ 0 1]);

figure();
histogram(sM(1,:)-sM(2,:));

[~,stats.ROI_mean_p] = ttest(sM(1,:),sM(2,:));
[stats.ROI_mean_p_ranksum,~] = ranksum(sM(1,:),sM(2,:));


% Export Data
var_data.Stat_Difference = HH;
var_data.Stat_alpha = alphaVal;
var_data.PearsonScores_D= sumD(:);
var_data.PearsonScores_U = sumU(:);
var_data.MeanPearsonScores = sM;

% figure();
% bar(sumU(:),sumD(:))
sum(HH)/size(HH,2)*100;

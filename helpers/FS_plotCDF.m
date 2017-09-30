function FS_plotCDF(X1,X2)

% X1 = undirected 
% X2 = directed


%%% Histogram

figure(); 

h11 = histogram(X2,'facecolor',[0,1,0],'facealpha',.5,'edgecolor','none'); hold on;
h12 = histogram(X1,'facecolor',[1,0,1],'facealpha',.5,'edgecolor','none'); hold on;
hold off;
 h11.BinWidth = 0.5;
 h12.BinWidth = 0.5;
h11.Normalization = 'probability';
h12.Normalization = 'probability';

%%% cdf
figure();
subplot(1,2,1)
[f1,x1,flo1,fup1] = ecdf(abs(X2-mean(X2)));
[f2,x2,flo2,fup2] = ecdf(abs(X1-mean(X1)));
plot(x1,f1,'m', 'LineWidth',2);
hold on;
plot(x2,f2,'g', 'LineWidth',2);

h = patch([x2(2:end-1)' fliplr(x2(2:end-1)')],[flo2(2:end-1)' fliplr(fup2(2:end-1)')],'g');
alpha(.3)
set(h,'EdgeColor','None');
h = patch([x1(2:end-1)' fliplr(x1(2:end-1)')],[flo1(2:end-1)' fliplr(fup1(2:end-1)')],'m');
alpha(.3)
set(h,'EdgeColor','None');

title('CDF of peak timing differences')
xlabel('Time in frames')
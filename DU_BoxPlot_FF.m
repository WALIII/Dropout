function DU_BoxPlot_FF(At,Bt,Ct,Dt,Et);

% Normalize data- output is mean dff (across the quartile) for each
% 'event'
NDATA = mat2gray(Dt);
NDATA2 = mat2gray(At);
NDATA3 = mat2gray(Et);
NDATA4 = mat2gray(Ct);

figure();
boxplot(NDATA,'Notch','on');
title('df/f as a function of applied time warping');
ylabel('normalized df/f');

figure();
boxplot(NDATA2,'Notch','on');
title('Normalized Song Similarity as a function of warping');
ylabel('Song Similarity');

% 
figure();
boxplot(NDATA3,'Notch','on');
title('Normalized Song Amplitude as a function of warping');
ylabel('Song Similarity');


figure(); 
subplot(141);
plotSpread(NDATA);
title('df/f as a function of applied time warping');
subplot(142);
plotSpread(NDATA2);
title('Normalized Song Similarity as a function of warping');
subplot(143);
plotSpread(NDATA3);
title('Normalized Song Amplitude as a function of warping');
subplot(144);
plotSpread(NDATA4);
title('Warping as a function of warping')



figure(); 
subplot(141);
boxplot(NDATA,'Notch','on');
title('df/f as a function of applied time warping');
subplot(142);
boxplot(NDATA2,'Notch','on');
title('Normalized Song Similarity as a function of warping');
subplot(143);
boxplot(NDATA3,'Notch','on');
title('Normalized Song Amplitude as a function of warping');
subplot(144);
boxplot(NDATA4,'Notch','on');
title('Warping as a function of warping')

% 
% Song amplitude vs Df/f
% figure(); 
% hold on;
% col = ['r','g','b','c']
% for ix = 1:4;
%     hold on;
% plot(((Dt(:,ix))),((Ct(:,ix))),'o','Color',col(ix));
% clear ttt2 ttt toplot toplot2
% figure(); plot(mat2gray(Ea(:)),mat2gray(Da(:)),'o');
% test1 = mat2gray(Da(:));
% test2 = mat2gray(Ba(:));
% test3 = mat2gray(Ea(:));
% counter = 1;
% for i = 0:.1:1;
%     toplot{counter} = test1(find(test3>i & test3<(i+1)));
%     toplot2{counter} = test2(find(test3>i & test3<(i+1)));
% 
% 
%     Bxv(:,counter) = mean(toplot{counter});
%     err(:,counter) = std(toplot{counter})/sqrt(length(toplot{counter}));
%     
%     Bxv2(:,counter) = mean(toplot2{counter});
%     err2(:,counter) = std(toplot2{counter})/sqrt(length(toplot2{counter}));
%     
% 
% counter = counter+1;
% end
% figure(); 
% hold on;
% errorbar(1:length(Bxv),Bxv,err)
% errorbar(1:length(Bxv2),Bxv2,err2)

% hold on;
% end
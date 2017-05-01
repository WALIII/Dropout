function scraphist(D_TDif,D_HDif,U_HDif,U_TDif);
figure();
h11 = histogram(U_TDif,'facecolor','m');
hold on
h21 = histogram(D_TDif,'facecolor','g');

h11.Normalization = 'probability';
h11.BinWidth = 3.5;
h21.Normalization = 'probability';
h21.BinWidth = 3.5;

figure();
h11 = histogram(abs(U_TDif),'facecolor','m');
hold on
h21 = histogram(abs(D_TDif),'facecolor','g');

h11.Normalization = 'probability';
h11.BinWidth = 1;
h21.Normalization = 'probability';
h21.BinWidth = 1;
title('Timing of major peak relative to average, for every ROI on every trial');
xlabel(' distance from average peak, in frames');
ylabel('probability');




figure();
h1 = histogram(U_HDif-0.6,'facecolor','m');
hold on
h2 = histogram(D_HDif-0.6,'facecolor','g');

h1.Normalization = 'probability';
h1.BinWidth = 0.25;
h2.Normalization = 'probability';
h2.BinWidth = 0.25;
title('Amplitude variability at the Peak')
ylabel('probability');
xlabel(' STD ');
set(h1,'EdgeColor','None');
set(h2,'EdgeColor','None');



%%% cdf
figure();
subplot(1,2,1)
[f1,x1,flo1,fup1] = ecdf(abs(U_TDif));
[f2,x2,flo2,fup2] = ecdf(abs(D_TDif));
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

subplot(1,2,2)
[f1,x1,flo1,fup1] = ecdf(abs(U_HDif));
[f2,x2,flo2,fup2] = ecdf(abs(D_HDif));

hold on;

h = patch([x2(2:end-1)' fliplr(x2(2:end-1)')],[flo2(2:end-1)' fliplr(fup2(2:end-1)')],'g');
alpha(.3)
set(h,'EdgeColor','None');
h = patch([x1(2:end-1)' fliplr(x1(2:end-1)')],[flo1(2:end-1)' fliplr(fup1(2:end-1)')],'m');
alpha(.3)
set(h,'EdgeColor','None');

plot(x1,f1,'m', 'LineWidth',2);
plot(x2,f2,'g', 'LineWidth',2);

%h = fill([x2' x2'],[f2'-flo2' fliplr(f2'+fup2')],'g'); alpha(.5)




% legend('Undirected','Directed');
title('CDF of peak height differences')
xlabel('STD')

[h,p] = kstest2(abs(U_HDif),abs(D_HDif))

% figure(); 
% ecdf(abs(D_HDif),'bounds','on')
 
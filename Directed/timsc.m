

for(i=1:40),
   
a=corrcoef((data.directed(:,:,i))')
[q,r]=size(a);
md(:,i)=(a(1:q*r))';

end

for(i=1:40),
   
a=corrcoef((data.undirected(:,:,i))')
[q,r]=size(a);
mu(:,i)=(a(1:q*r))';

end

figure(3)
hold on

subplot(3,1,1)
boxplot(mu);
subplot(3,1,2);
boxplot(md);
subplot(3,1,3);

hold on

plot(std(mu),'mo');
hold on
plot(std(md),'go');
title('std of correcoeff matrix: green=directed')


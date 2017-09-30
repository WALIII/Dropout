function [mu md] = timsc(data);

cel = size(data.undirected,3);
for(i=1:cel),
   
a=corrcoef((data.directed(:,1:end,i))');
[q,r]=size(a);
md(:,i)=(a(1:q*r))';

end

for(i=1:cel),
   
a=corrcoef((data.undirected(:,1:end,i))');
[q,r]=size(a);
mu(:,i)=(a(1:q*r))';

end

figure()
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


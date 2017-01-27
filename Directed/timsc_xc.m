


for(i=1:30),
  n=data.directed(:,:,i);
   [a1,a2]=size(n);
   
   n=n-mean(n(1:a1*a2));
   n=n/std(n(1:a1*a2));
   a=(xcorr(n',5));
   [a1,a2]=max(a);
md(:,i)=a1;

end

for(i=1:30),
   n=data.undirected(:,:,i);
   [a1,a2]=size(n);
   
   n=n-mean(n(1:a1*a2));
   n=n/std(n(1:a1*a2));
   

     a=(xcorr(n',5));

     [a1,a2]=max(a);
    mu(:,i)=a1;



end

figure(3)
hold on

subplot(3,1,1)
boxplot(mu);
title('undirected');
ylim([-10 30])
subplot(3,1,2);
boxplot(md);
title('directed');
ylim([-10 30])
subplot(3,1,3);

hold on

plot(median(mu),'r');

plot(median(md),'g');

%plot(std(mu),'ro');
%hold on
%plot(std(md),'go');
title('median xcorr value across trials : green=directed')

figure(4);
z=[(median(mu))' (median(md))']
boxplot(z)
%pvalue
ranksum(z(:,1), z(:,2))


function [D1 D2] = scrap1(SortedCell);
counter = 1;

for i = 1:70
D1(:,counter) = mean(var(squeeze(SortedCell(i,1:100,:))));
counter=counter+1;
end

counter = 1;
for i = 75:98
D2(:,counter) = mean(var(squeeze(SortedCell(i,1:100,:))));
counter = counter+1;
end

figure(); 
title('populaiton variance');
plot(ones(1,length(D1)),D1,'r*');
hold on;
plot(ones(1,length(D2))+1,D2,'b*');
xlim([0 3]);

% for i = 1:50
% line([1,2],[D1(:,i),D2(:,i)]);
% hold on;
% end

% variance of cells;

clear D1;
clear D2;

mxCl = 50; % max cell
counter = 1;

for i = 1:mxCl;
D1(:,counter) = mean(var(squeeze(SortedCell(10:30,1:60,i)),0,1));
counter=counter+1;
end

counter = 1;
for i = 1:mxCl;
D2(:,counter) = mean(var(squeeze(SortedCell(75:94,1:60,i)),0,1));
counter = counter+1;
end

figure(); 
title('ROI variance');
plot(ones(1,length(D1)),D1,'r*');
hold on;
plot(ones(1,length(D2))+1,D2,'b*');
xlim([0 3]);

hold on;

for i = 1:mxCl
line([1,2],[D1(:,i),D2(:,i)]);
hold on;
end

figure
boxplot([D1',D2'],'Notch','on','Labels',{'mu = 5','mu = 6'})
title('Compare Random Data from Different Distributions')


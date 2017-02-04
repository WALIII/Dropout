function  FS_plot(data)
counter = 1;


mxCl = 44; % max cell
counter = 1;

for i = 1:mxCl;
D1(:,counter) = mean(var(squeeze(data.directed(:,:,i)),0,1));
counter=counter+1;
end

counter = 1;
for i = 1:mxCl;
D2(:,counter) = mean(var(squeeze(data.undirected(:,:,i)),0,1));
counter = counter+1;
end

figure(); 
title('ROI variance');
plot(ones(1,length(D1)),D1,'r*','MarkerSize',10);
hold on;
plot(ones(1,length(D2))+1,D2,'b*','MarkerSize',10);
xlim([0 3]);

hold on;

for i = 1:mxCl
line([1,2],[D1(:,i),D2(:,i)]);
hold on;
end

figure
boxplot([D1',D2'],'Notch','on','Labels',{'Directed','Undirected'})
title('comparison of Variance across ROIs')


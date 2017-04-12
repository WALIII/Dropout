function  FS_plot(data)
counter = 1;


mxCl = 20; % max cell
counter = 1;

for i = 1:mxCl;
D1(:,counter) = mean(var(squeeze(data.directed(:,:,i)),0,1));
counter=counter+1;
end


counter = 1;
for i = 1:mxCl;
D2(:,counter) = mean(var(squeeze(data.undirected(:,:,i)),0,1));
D3(:,counter) = D1(:,counter)-D2(:,counter);
counter = counter+1;
end

figure(); 
title('ROI variance');
plot(ones(1,length(D1)),D1,'g*','MarkerSize',10);
hold on;
plot(ones(1,length(D2))+1,D2,'m*','MarkerSize',10);
xlim([0 3]);

hold on;

for i = 1:mxCl
line([1,2],[D1(:,i),D2(:,i)]);
hold on;
end

figure
boxplot([D1',D2'],'Notch','on','Labels',{'Directed','Undirected'})
title('comparison of Variance across ROIs')


%%%

figure(); 
title('ROI variance');
plot(ones(1,length(D3)),zeros(1,length(D3)),'g*','MarkerSize',10);
hold on;
plot(ones(1,length(D3))+1,D3,'m*','MarkerSize',10);
xlim([0 3]);

hold on;

for i = 1:mxCl
line([1,2],[0,D3(:,i)]);
hold on;
end

figure
boxplot([D1',D2'],'Notch','on','Labels',{'Directed','Undirected'})
title('comparison of Variance across ROIs')




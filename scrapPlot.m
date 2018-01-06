function scrapPlot(data)

figure();
D = {'g','m','b','c','y','r','k'};
for i = 1:size(data,2);

 x = 1:size(data{i}',2);
 hold on;
 shadedErrorBar(x,data{i}',{@mean,@std},D{i},0);

end

figure();
for i = 1:size(data,2)

 x = 1:size(data{i}',2);
 hold on;
 plot(x,mean(data{i},2),D{i});

end



 
 
 
 
 
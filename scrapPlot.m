function scrapPlot(data1,data2)

x = 1:length(data1);

 figure();
 shadedErrorBar(x,data1,{@mean,@std},'g',1);
 hold on;
 shadedErrorBar(x,data2,{@mean,@std},'b',1);
 
 
 
 
 
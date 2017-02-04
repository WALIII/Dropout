function scrapPlot(data1,data2)

x = 1:size(data1,2);

 shadedErrorBar(x,data1,{@mean,@std},'g',0);
 hold on;
 shadedErrorBar(x,data2,{@mean,@std},'m',0);
 
 
 
 
 
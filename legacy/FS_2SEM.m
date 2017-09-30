function  FS_2SEM(roi_ave)
% plot 2sem 

figure(); 

for cell = 1:50; 

for i = 1:36; 

G(i,:) = tsmovavg(zscore(roi_ave.interp_raw{cell,i}),'s',3); 


%plot((G(4:end))+cell*5); 

hold on; 

end; 
data = (G(:,3:end));
L = length(data);
se = std(data)/sqrt(length(data))
mn = mean(data)+cell*2;
 
plot(mn);
fill([1:L L:-1:1],[mn-se fliplr(mn+se)],[0.5 0.5 0.5]); alpha(.5)
end
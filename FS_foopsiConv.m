function [foopsi_data] =  FS_foopsiConv(data)

for ii = 1: size(data.directed,3)
%DIRECTED
Ymean = mean(squeeze(data.directed(:,2:end-5,ii)));
for i = 1:size(data.directed,1)
    G = tsmovavg(squeeze(data.directed(i,2:end-5,ii)),'s',4);
    y(i,:) = G(4:end)+abs(min(Ymean));

    [c(:,i),b,c1,g,sn,sp(:,i)] = constrained_foopsi(y(i,:));
  foopsi_data.directed(i,:,ii) = c(:,i);  
  foopsi_data.directed_sp(i,:,ii) = sp(:,i);

end

%UNDIRECTED
Ymean = mean(squeeze(data.undirected(:,2:end-5,ii)));
for i = 1:size(data.undirected,1)
    G2 = tsmovavg(squeeze(data.undirected(i,2:end-5,ii)),'s',4);
    y2(i,:) = G2(4:end)+abs(min(Ymean));

    [c2(:,i),b,c1,g,sn,sp2(:,i)] = constrained_foopsi(y2(i,:));
  foopsi_data.undirected(i,:,ii) = c2(:,i);  
  foopsi_data.undirected_sp(i,:,ii) = sp2(:,i);
end


end


    
    
    
    

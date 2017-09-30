function FS_foopsi(data, cell)

close all
clear y;
clear c;
clear sp;
clear G
figure();
%cell = 1; % 29

for i = 1:size(data.directed,1)
    subplot(221)
    title('Directed ROIs, raw(red) and mean(blue)');
Ymean = mean(squeeze(data.directed(:,2:end-5,cell)));
plot(Ymean+abs(min(Ymean)),'b');
    
    G = tsmovavg(squeeze(data.directed(i,2:end-5,cell)),'s',2);
    y(i,:) = G(2:end)+abs(min(Ymean));
    plot(y(i,:),'r');
    
    shiftup = 0;
    
  [pks,locs] = findpeaks(y(i,:),'MinPeakWidth',2,'MinPeakProminence',1*std(y(i,:)));
      hold on; plot(locs,pks+shiftup,'*');% line([locs(:,:)/22,locs(:,:)/22],[-1 9],'Color',c(i,:))
 
    
   subplot(223) 
   title('Deconvolved directed ROIs (blue) inferred spikes(green)');
    [c(:,i),b,c1,g,sn,sp(:,i)] = constrained_foopsi(y(i,:));
     plot(zscore(c(:,i)),'b');
    %plot(zscore(sp(:,i)),'g');
    hold on;
end



for i = 1:size(data.undirected,1)
subplot(222)
    title('UnDirected ROIs, raw(red) and mean(blue)');

Ymean = mean(squeeze(data.undirected(:,2:end-5,cell)));
plot(Ymean+abs(min(Ymean)),'b');
    
    G = tsmovavg(squeeze(data.undirected(i,2:end-5,cell)),'s',2);
    y(i,:) = G(2:end)+abs(min(Ymean));
    plot(y(i,:),'r');
    
    shiftup = 0;
    
  [pks,locs] = findpeaks(y(i,:),'MinPeakWidth',2,'MinPeakProminence',1*std(y(i,:)));
      hold on; plot(locs,pks+shiftup,'*');% line([locs(:,:)/22,locs(:,:)/22],[-1 9],'Color',c(i,:))
    
    subplot(224)
title('Deconvolved Undirected ROIs (blue) inferred spikes(green)');

    [c(:,i),b,c1,g,sn,sp(:,i)] = constrained_foopsi(y(i,:));
     plot(zscore(c(:,i)),'b');
   % plot(zscore(sp(:,i)),'g');
    hold on;
end

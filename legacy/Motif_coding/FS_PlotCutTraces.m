function  FS_PlotCutTraces(SortedCell,idx,Tally2,cell)
% Context Dependance prototype function  


figure(); 
for i = cell
    hold on;
 
SCell = SortedCell(:,:,i);



S2 = (SCell(idx, 1:end-round((0.5e5/48000)*30)));
S1 = Tally2(idx, 1:end-0.5e5);

% figure(); 
ax1 = subplot(1,11,1:5);
imagesc(S1);
ax2 = subplot(1,11,6:10);
imagesc(S2);

colormap(hot)

linkaxes([ax1,ax2],'y');

counter = 1;
c1 = 1;
c2 = 1;
c3 = 1;
c4 = 1;
end




% figure(); 

%  n = 4;
%  

 % Cell 1
% for i = 1:15; plot(zscore(SCell(idx(i),:))+counter*n,'g'); hold on; 
% Cell_1(c1,:) = (SCell(idx(i),:));
% c1 = c1+1;
% end
% 
% for i = 28:56; plot(SCell(idx(i),:)+counter*n,'g'); hold on; 
% Cell_1(c3,:) = SCell(idx(i),:);
% c3 = c3+1;
% end
% counter = counter-1;
% 
% % Cell 2
% for i = 16:27; plot(zscore(SCell(idx(i),:))+counter*n,'b'); hold on;
% Cell_2(c2,:) = zscore(SCell(idx(i),:));
% c2 = c2+1;
% end

% 
% for i = 57:67; plot(zscore(SCell(idx(i),:))+counter*n,'b'); hold on;
% Cell_2(c2,:) = (SCell(idx(i),:));
% c2 = c2+1;
% end
% counter = counter-1;
% % 
% % Cell 3
% for i = 38:47; plot(zscore(SCell(idx(i),:))+counter*n,'r'); hold on; 
% Cell_3(c3,:) = zscore(SCell(idx(i),:));
% c3 = c3+1;
% end

% for i = 261:270; plot(SCell(idx(i),:)+counter*n,'r'); hold on; 
% Cell_3(c3,:) = SCell(idx(i),:);
% c3 = c3+1;
% end
% counter = counter-1;

% Cell 4;
% for i = 43:50; plot(SCell(idx(i),:)+counter*n,'c'); hold on;
% Cell_4(c4,:) = SCell(idx(i),:);
% c4 = c4+1;
% end
% for i = 271:440 plot(SCell(idx(i),:)+counter*n,'c'); hold on; 
% Cell_4(c4,:) = SCell(idx(i),:);
% c4 = c4+1;
% end



% counter = counter-1;
% 
% 
% 
% 

% 
% %  y = Cell_1;
%  
%  
%  
%  
% 
%  figure();
%  shadedErrorBar(x,Cell_1,{@mean,@std},'g',1);
%  hold on;
%  shadedErrorBar(x,Cell_2,{@mean,@std},'b',1);
%  shadedErrorBar(x,Cell_3,{@mean,@std},'b',1);
%  shadedErrorBar(x,Cell_4,{@mean,@std},'c',1);


% % Interpolated data
% 
%  x = 1:length(Cell_1);
%  
%  t_new = linspace(1, numel(), round(48000*numel(M))/30-1);
%  Mt = interp1(M, t_new), 
% 
%  figure();
%  shadedErrorBar(x,Cell_1,{@mean,@std},'r',1);
%  hold on;
%  shadedErrorBar(x,Cell_2,{@mean,@std},'g',1);
%  shadedErrorBar(x,Cell_3,{@mean,@std},'b',1);
%  shadedErrorBar(x,Cell_4,{@mean,@std},'c',1);






 
%  
%  
% %  AA1 = Cell_2-Cell_1;
% %  AA2 = Cell_3-Cell_1;
% %  AA3 = Cell_4-Cell_1;
% %  
% %  
% %  figure(); 
% %  subplot(3,1,1);
% %  plot(mean(Cell_2,1)-mean(Cell_1,1),'b');
% %  hold on;
% %  plot(mean(Cell_3,1)-mean(Cell_1,1),'r');
% %  plot(mean(Cell_4,1)-mean(Cell_1,1),'c');
% %  title('Subtracting the First Motif')
% %  legend('2 Motifs','3 Motifs','4 Motifs')
% % 
% %   subplot(3,1,2);
% %  plot(mean(Cell_1,1)-mean(Cell_2,1),'g');
% %  hold on;
% %  plot(mean(Cell_3,1)-mean(Cell_2,1),'r');
% %  plot(mean(Cell_4,1)-mean(Cell_2,1),'c');
% %   title('Subtracting the Second Motif')
% %  legend('2 Motifs','3 Motifs','4 Motifs')
% % 
% %  
% %   subplot(3,1,3);
% %  plot(mean(Cell_2,1)-mean(Cell_3,1),'b');
% %  hold on;
% %  plot(mean(Cell_1,1)-mean(Cell_3,1),'g');
% %  plot(mean(Cell_4,1)-mean(Cell_3,1),'c');
% %  title('Subtracting the Third Motif')
% %  legend('2 Motifs','3 Motifs','4 Motifs')
% %  
% %  
%  
%  
% %  for i = 1: 100;
%      
%  %==========
%  %  y = Cell_1;
% %  x = 1:length(Cell_1);
% % y_mean = mean(Cell_1,3); y_std = std(Cell_1,[],3);
% lineProps1.col{1} = 'g'; 
% lineProps2.col{1} = 'b'; 
% lineProps3.col{1} = 'r';
% lineProps4.col{1} = 'c';

%  figure();
% mseb(x,mean(Cell_1,1),std(Cell_1,[],1),lineProps1);
%  hold on;
% mseb(x,mean(Cell_2,1)+5,std(Cell_2,[],1),lineProps2);
% mseb(x,mean(Cell_3,1)+10,std(Cell_3,[],1),lineProps3);
% mseb(x,mean(Cell_4,1)+15,std(Cell_4,[],1),lineProps4);







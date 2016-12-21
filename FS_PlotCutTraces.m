function FS_PlotCutTraces(SortedCell)
% Context Dependance prototype function  


SCell = SortedCell{53}


S2 = abs(SCell(idx, :));
S1 = Tally2(idx, :);
figure(); 
subplot(1,2,1)
imagesc(S1);
subplot(1,2,2)
imagesc(S2);
colormap(hot)

counter = 1;
c1 = 1;
c2 = 1;
c3 = 1;
c4 = 1;
figure(); 
 n = 4;
 
 % Cell 1
for i = 6:13; plot(SCell(idx(i),:)+counter*n,'g'); hold on; 
Cell_1(c1,:) = SCell(idx(i),:);
c1 = c1+1;
end
counter = counter-1;

% Cell 2
for i = 14:32; plot(SCell(idx(i),:)+counter*n,'b'); hold on;
Cell_2(c2,:) = SCell(idx(i),:);
c2 = c2+1;
end
counter = counter-1;

% Cell 3
for i = 1:5; plot(SCell(idx(i),:)+counter*n,'r'); hold on; 
Cell_3(c3,:) = SCell(idx(i),:);
c3 = c3+1;
end

for i = 37:44; plot(SCell(idx(i),:)+counter*n,'r'); hold on; 
Cell_3(c3,:) = SCell(idx(i),:);
c3 = c3+1;
end
counter = counter-1;

% Cell 4;
for i = 33:36; plot(SCell(idx(i),:)+counter*n,'c'); hold on;
Cell_4(c4,:) = SCell(idx(i),:);
c4 = c4+1;
end
for i = 48; plot(SCell(idx(i),:)+counter*n,'c'); hold on; 
Cell_4(c4,:) = SCell(idx(i),:);
c4 = c4+1;
end

counter = counter-1;





%  y = Cell_1;
 x = 1:length(Cell_1);
 

 figure();
 shadedErrorBar(x,Cell_1,{@mean,@std},'g',1);
 hold on;
 shadedErrorBar(x,Cell_2,{@mean,@std},'b',1);
 shadedErrorBar(x,Cell_3,{@mean,@std},'r',1);
 shadedErrorBar(x,Cell_4,{@mean,@std},'c',1);
 
 
 
%  AA1 = Cell_2-Cell_1;
%  AA2 = Cell_3-Cell_1;
%  AA3 = Cell_4-Cell_1;
 
 
%  figure(); 
%  subplot(3,1,1);
%  plot(mean(Cell_2,1)-mean(Cell_1,1),'b');
%  hold on;
%  plot(mean(Cell_3,1)-mean(Cell_1,1),'r');
%  plot(mean(Cell_4,1)-mean(Cell_1,1),'c');
%  title('Subtracting the First Motif')
%  legend('2 Motifs','3 Motifs','4 Motifs')
% 
%   subplot(3,1,2);
%  plot(mean(Cell_1,1)-mean(Cell_2,1),'g');
%  hold on;
%  plot(mean(Cell_3,1)-mean(Cell_2,1),'r');
%  plot(mean(Cell_4,1)-mean(Cell_2,1),'c');
%   title('Subtracting the Second Motif')
%  legend('2 Motifs','3 Motifs','4 Motifs')
% 
%  
%   subplot(3,1,3);
%  plot(mean(Cell_2,1)-mean(Cell_3,1),'b');
%  hold on;
%  plot(mean(Cell_1,1)-mean(Cell_3,1),'g');
%  plot(mean(Cell_4,1)-mean(Cell_3,1),'c');
%  title('Subtracting the Third Motif')
%  legend('2 Motifs','3 Motifs','4 Motifs')
%  
 
 
 
%  for i = 1: 100;
     
 %==========
 %  y = Cell_1;
%  x = 1:length(Cell_1);
% y_mean = mean(Cell_1,3); y_std = std(Cell_1,[],3);
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







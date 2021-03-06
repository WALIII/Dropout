function [indX,B,C] = FS_schnitz(data)

Cel =  size(data.directed,3);
index_ref = cat(1,data.directed,data.undirected);

for i = 1:Cel;
    R(i,:) = (var(index_ref(:,:,i),1));
end


clear G;
clear G2
for i = 1:Cel;
    G(i,:) = zscore((mean(data.directed(:,:,i),1)));
    G_std(i,:) = ((var(data.directed(:,:,i),[],1)));
end

for i = 1:Cel;
    G2(i,:) = zscore((mean(data.undirected(:,:,i),1)));
    G2_std(i,:) = ((var(data.undirected(:,:,i),[],1)));
end


[maxA, Ind] = max(G, [], 2);
[dummy, index] = sort(Ind);

B  = (G(index, :));
C  = (G2(index, :));
B_2  = (G_std(index, :));
C_2  = (G2_std(index, :));
% D =  (R(index, :));
indX = index;
figure();

subplot(1,2,1)
imagesc((B), [0, 3]);
title('Directed Trials');
ylabel('ROIs');
xlabel('Frames');
hold on;
subplot(1,2,2)


imagesc((C), [0, 3] );

title('UnDirected Trials');
ylabel('ROIs');
xlabel('Frames');
 colormap(hot);

 colorbar




 figure();

subplot(1,2,1)
imagesc((B_2) );
title('Directed Trials');
ylabel('ROIs');
xlabel('Frames');
hold on;
subplot(1,2,2)


imagesc((C_2) );

title('UnDirected Trials');
ylabel('ROIs');
xlabel('Frames');
 colormap(hot);

 colorbar
 
 % figure();
%
% subplot(1,2,1)
% imagesc(B);
% title('Directed Trials');
% ylabel('ROIs');
% xlabel('Frames');
%
% subplot(1,2,2)
%
% imagesc(C);
%
% title('UnDirected Trials');
% ylabel('ROIs');
% xlabel('Frames');
% % colormap(hot);

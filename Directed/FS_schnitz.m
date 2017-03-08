function FS_schnitz(data)

Cel = 40; %size(data.directed,3);
index_ref = cat(1,data.directed,data.undirected);

for i = 1:Cel;
    R(i,:) = (var(index_ref(:,:,i),1));
end


clear G;
for i = 1:Cel;
    G(i,:) = (mean(data.directed(:,:,i),1));
end

for i = 1:Cel;
    G2(i,:) = (mean(data.undirected(:,:,i),1));
end


[maxA, Ind] = max(G, [], 2);
[dummy, index] = sort(Ind);
 
B  = (G(index, :));
C  = (G2(index, :));
% D =  (R(index, :));

figure(); 

subplot(1,2,1)
imagesc(B, [0, 3]);
title('Directed Trials');
ylabel('ROIs');
xlabel('Frames');

subplot(1,2,2)


imagesc(C, [0, 3] );

title('UnDirected Trials');
ylabel('ROIs');
xlabel('Frames');
 colormap(hot);

 colorbar

X = B-C;
[maxA, Ind] = max(X, [], 2);
[dummy, index] = sort(Ind);


XX =  (X(index, :));




figure(); 
imagesc(XX,[-2 2]);
%colormap(fireice);
colorbar;

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





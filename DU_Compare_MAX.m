

% % If out was not calculated:
% [out] =  DU_Align_Combined(out,out.index.song_start,out.index.song_end,results);
% % Load context index...
% out = DU_Check_Directed(out, directed,undirected);

figure(); 
for i = 1:size(out.allVids,4)
bk = min(squeeze(out.allVids(:,:,:,i)),[],3);
[maxproj(:,:,i), allVids2(:,:,:,i)] = ImBat_Dff(out.allVids(:,:,:,i));
end


 ind1 = find(out.index.aligned_directed>0);
 ind2 = find(out.index.aligned_directed<1);


% inds = randperm(100);
% ind1 = inds(1:30);
% ind2 = inds(31:60);


% Make colormap
 colorMap1 = [ones(256,1),(linspace(0,1,256)').^.1,ones(256,1), ];
colorMap2 = [flipud(linspace(0,1,256)').^.1,ones(256,1), flipud(linspace(0,1,256)').^.1];
colorMap3 = cat(1,colorMap1,colorMap2);


xx = size(ind1,2);
xx2 = size(ind2,2);

if xx<xx2;
ind2UseA = ind1;
ind2UseB = ind2(end-(xx):end);
else
ind2UseA = ind1(end-(xx2):end);
ind2UseB = ind2;
end

% A = squeeze(max(max(allVids2(:,:,20:50,ind1),[],3),[],4));
% B = squeeze(max(max(allVids2(:,:,20:50,ind2(1:xx)),[],3),[],4));
% 

 A = squeeze(sum(max(allVids2(:,:,10:60,ind2UseA),[],3),4));
 B = squeeze(sum(max(allVids2(:,:,10:60,ind2UseB),[],3),4)); % not to bias






figure(); 
subplot(141);
imagesc(A);
colormap(gray);
freezeColors
title('Sum of Max Projection of Directed Song');


subplot(142);
imagesc(B);
colormap(gray);
freezeColors
title('Sum of Max Projection of UnDirected Song');


subplot(143);
 imagesc((A-B)./(A+B));
 colormap(parula);
%  colormap(colorMap3);
 title('Directed Dprime, -Undirected Dprime');
colorbar();






figure(); imagesc(mat2gray(A)-mat2gray(B),[-.5 .5]);colormap(colorMap3)




 ind1 = find(out.index.aligned_directed>0);
 ind2 = find(out.index.aligned_directed<1);

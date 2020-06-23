function out2 = DU_Compare_MAX(out,metadata)

% % If out was not calculated:
% [out] =  DU_Align_Combined(out,out.index.song_start,out.index.song_end,results);
% % Load context index...
% out = DU_Check_Directed(out, directed,undirected);

h2=fspecial('gaussian',5,5);

out.allVids(:,:,:,1) = out.allVids(:,:,:,3);

for i = 1:size(out.allVids,4)
bk = min(squeeze(out.allVids(:,:,:,i)),[],3);
[maxproj(:,:,i), allVids2(:,:,:,i)] = ImBat_Dff(out.allVids(:,:,:,i),'filt_rad',5);
[Cnproj(:,:,i), temp] = ImBat_correlation_image(out.allVids(:,:,:,i),metadata);

maxproj2(:,:,i) = imfilter(temp,h2,'circular');
disp(['finished video: ',num2str(i)]);
end


 ind1 = find(out.index.aligned_directed>0);
 ind2 = find(out.index.aligned_directed<1);


% inds = randperm(100);
% ind1 = inds(1:30);
% ind2 = inds(31:60);


% Make colormap
 colorMap1 = [zeros(256,1),(linspace(0,1,256)'),zeros(256,1), ];
colorMap2 = [flipud(linspace(0,1,256)'),zeros(256,1), flipud(linspace(0,1,256)')];
colorMap3 = cat(1,colorMap2.^2,colorMap1.^2);


figure(); colormap(colorMap3); colorbar();

xx = size(ind1,2);
xx2 = size(ind2,2);

if xx<xx2;
ind2UseA = ind1;
ind2UseB = ind2(end-(xx)+1:end);
else
ind2UseA = ind1(1:(xx2));
ind2UseB = ind2;
end

out2.max_proj_directed = squeeze((max(allVids2(:,:,:,ind2UseA),[],3)));
out2.max_proj_undirected = squeeze((max(allVids2(:,:,:,ind2UseB),[],3)));

out2.max_PNR_directed = maxproj2(:,:,ind2UseA);
out2.max_PNR_undirected = maxproj2(:,:,ind2UseB);

A_pnr = std(maxproj2(:,:,ind2UseA),[],3);
B_pnr = std(maxproj2(:,:,ind2UseB),[],3);
% 
h=fspecial('gaussian',50,50);
 A = squeeze(sum(max(allVids2(:,:,:,ind2UseA),[],3),4));
 A_filt=imfilter(A,h,'circular');
 B = squeeze(sum(max(allVids2(:,:,:,ind2UseB),[],3),4)); % not to bias
 B_filt=imfilter(B,h,'circular');
 
 A = A./A_filt;
 B = B./B_filt;
 
% Calculate RGB
[RGB1 RGB2] = CaBMI_XMASS(B_pnr,A_pnr,B_pnr,'normalize',2,'hl',[0.05,0.6]); 
figure(); imagesc(RGB1)

figure(); 
subplot(141);
imagesc(A,[0.8 2]);
colormap(gray);
freezeColors
% colorbar
title('Sum of Max Projection of Directed Song');

subplot(142);
imagesc(B,[0.8 2]);
colormap(gray);
freezeColors
title('Sum of Max Projection of UnDirected Song');

subplot(143);
 imagesc((A-B)./(A+B),[-0.25 0.23]);
% colormap(parula);
  colormap(colorMap3);
 title('(D-U)./(D+U)');
% colorbar();

subplot(144);
 imagesc(RGB1);
%  colormap(colorMap3);
 title('STD PNR OVERLAY');
% colorbar();





% figure(); imagesc((A_pnr-B_pnr)./(A_pnr+B_pnr),[-0.5 0.5]);colormap(colorMap3)
% colorbar();

% 
% 
%  ind1 = find(out.index.aligned_directed>0);
%  ind2 = find(out.index.aligned_directed<1);

function FS_cellclust_ROI(data)

[s1 s2 s3] = size(data.directed);
A = data.directed;
A2 = permute(A,[2 1 3]);
A3 = reshape(A2,[s1*s2,s3]);
[s1 s2 s3] = size(data.directed);
B = data.undirected;
B2 = permute(B,[2 1 3]);
B3 = reshape(B2,[s1*s2,s3]);
    
    A3 = A3';
    B3 = B3';
    
    figure();
    subplot(121);
clim = [-0.3 0.8];
l = linkage(A3, 'average', 'correlation');
c=cluster(l,'maxclust',5);
[aa,bb]=sort(c);
CVC2=cov(A3(:,bb));
eig1 = CVC2;
imagesc(CVC2,clim);
title('Sorted Covariance matrix')
% colormap(hot)

    subplot(122);
clim = [-0.3 0.8];
% l = linkage(B3, 'average', 'correlation');
% c=cluster(l,'maxclust',5);
% [aa,bb]=sort(c);
CVC2=cov(B3(:,bb));
eig1 = CVC2;
imagesc(CVC2,clim);
title('Sorted Covariance matrix')
% colormap(hot)
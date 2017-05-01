function FS_cellclust_ROI(data)


A = data.undirected;
[s1 s2 s3] = size(A);
A2 = permute(A,[2 1 3]);
A3 = reshape(A2,[s1*s2,s3]);

B = data.directed;
[s1 s2 s3] = size(B);
B2 = permute(B,[2 1 3]);
B3 = reshape(B2,[s1*s2,s3]);
    
    A3 = A3';
    B3 = B3';
    
    figure();
    subplot(121);
clim = [-0.1 0.8];
l = linkage(A3, 'average', 'correlation');
c=cluster(l,'maxclust',10);
[aa,bb]=sort(c);
CVC2=cov(A3(:,bb));
eig1 = CVC2;
imagesc(CVC2,clim);
title('Sorted Covariance matrix')
% colormap(hot)

    subplot(122);

% l = linkage(B3, 'average', 'correlation');
% c=cluster(l,'maxclust',5);
% [aa,bb]=sort(c);
CVC2=cov(B3(:,bb));
eig1 = CVC2;
imagesc(CVC2,clim);
title('Sorted Covariance matrix')
% colormap(hot)
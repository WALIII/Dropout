
function FS_PlotCov_test(
% Take cells that have the ~Max and ~Min Covariance, and plot these cells
% together, in each condition. 

CC = cov(GX);
CC(CC> 0.9) = 0;

[M1 I1] = max(CC); % max of row, and index. 

[M2 I2] = max(M1)% 
Cell1 = I2;
Cell2 = I1(I2);

% cell 1;
figure();
subplot(121)
plot(squeeze(data.directed(:,:,Cell1)'));
title('directed');
subplot(122)
plot(squeeze(data.directed(:,:,Cell2)'));
title('undirected');


% plot offsets
figure();

subplot(121);
hold on; 
for i = 1: 20;
    plot(squeeze(data.undirected(i,:,Cell1)')+i*4,'r');
end
subplot(122)
hold on;
for i = 1:20;
    plot(squeeze(data.undirected(i,:,Cell2)')+i*4,'r');
end


figure(); 
subplot(121)
imagesc(squeeze(data.directed(:,:,1)))
subplot(122)
imagesc(squeeze(data.directed(:,:,4)))


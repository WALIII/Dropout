
function [eig1,eig2,sorting]= FS_cellclust_comp(SortedCell,SortedCell2)
% Make covariance matirx for imaging data input format: SortedCell(trial,time,cell)
% TG
% modified by WAL3
% d011517

%close all;


% figure(); plot(SortedCell(:,:,1)');

startT = 2;
endT = size(SortedCell,2);
cells = size(SortedCell,3);
trials = size(SortedCell,1);
clim = [-.3 0.8];
maxlag_samps=round(25*.02);

MM_C2 = mean(SortedCell(:,startT:endT,:),3);

for cell = 1:cells % cells;
for trial = 1:trials % trials;

   % C(i,cell)=(max(ROI_data_cleansed{day}.raw_dat{cell,i})-median(ROI_data_cleansed{day}.raw_dat{cell,i}));
    C4(trial,cell)=std(SortedCell(trial,startT:endT,cell));
    C2(trial,cell)=mean(SortedCell(trial,startT:endT,cell));

    C3(trial,cell)=mean(SortedCell(trial,startT:endT,cell));

end;
%C(:,cell)=(C(:,cell)-mean(C(:,cell)))/(std(C(:,cell)));
end

data.total = cat(1, SortedCell,SortedCell2)
data.directed = SortedCell;
data.undirected = SortedCell2;
AVG_Trace = squeeze(mean(data.total,1));
for cell = 1:cells
  for trial = 1:trials;
    C(trial,cell) = max(xcorr(data.directed(trial,:,cell),AVG_Trace(:,cell),maxlag_samps,'coeff'))/max(xcorr(data.directed(trial,:,cell),(data.directed(trial,:,cell)),maxlag_samps,'coeff'));
  end
end

figure()
subplot(2,1,1)
imagesc(C);
xlabel('cells');
ylabel('trials');
title('STD')
subplot(2,1,2)
imagesc(C2);
xlabel('cells');
ylabel('trials');
title('MEAN')


q=sum(C');
j=1;
for(k=1:trials),
if(q(k)<140), % 140 seems resonable for minimum
    D(j,:)=C(k,:);
    D2(j,:)=C2(k,:);
    j=j+1;
end
end


for(cell=1:cells),
D3(:,cell)=(D(:,cell)-mean(D(:,cell)))/std(D(:,cell));
end
D=D3;

[cleantrials, c]=size(D);

%
% for(trial=1:trials),
% D4(trial,:)=D(trial,:)./mean(D(trial,:));
% end
% D=D4;


figure()
subplot(3,2,1)
imagesc(D);
ylabel('Trials');
xlabel('Cells');
title(' STD matrix for all ROIs');
subplot(3,2,3)
CVC=cov(D,1);
imagesc(CVC,clim);
title('unsorted covariance matrix');



l = linkage(CVC, 'average', 'correlation');

subplot(3,2,5)
c=cluster(l,'maxclust',10);
[aa,bb]=sort(c);
CVC2=cov(D(:,bb));
sorting  = bb;
eig1 = CVC2;
imagesc(CVC2,clim);
title('Sorted Covariance matrix')
% colormap(hot)
% colorbar


clear C;
clear C2;

clear D;
clear D2;
clear D3;
%%%% part 2


cells = size(SortedCell2,3);
trials = size(SortedCell2,1);



for cell = 1:cells % cells;
for trial = 1:trials % trials;

   % C(i,cell)=(max(ROI_data_cleansed{day}.raw_dat{cell,i})-median(ROI_data_cleansed{day}.raw_dat{cell,i}));
    C(trial,cell)=std(SortedCell2(trial,startT:endT,cell));
    C2(trial,cell)=mean(SortedCell2(trial,startT:endT,cell));

end;
%C(:,cell)=(C(:,cell)-mean(C(:,cell)))/(std(C(:,cell)));
end


for cell = 1:size(data.undirected,3)
  for trial = 1:trials;
    C(trial,cell) = max(xcorr(data.undirected(trial,:,cell),AVG_Trace(:,cell),maxlag_samps,'coeff'))/max(xcorr(data.undirected(trial,:,cell),(data.undirected(trial,:,cell)),maxlag_samps,'coeff'));
  end
end

% figure()
% subplot(2,1,1)
% imagesc(C);
% xlabel('cells');
% ylabel('trials');
% title('STD')
% subplot(2,1,2)
% imagesc(C2);
% xlabel('cells');
% ylabel('trials');
% title('MEAN')


q=sum(C');
j=1;
for(k=1:trials),
if(q(k)<140), % 140 seems resonable for minimum
    D(j,:)=C(k,:);
    D2(j,:)=C2(k,:);
    j=j+1;
end
end


for(cell=1:cells),
D3(:,cell)=(D(:,cell)-mean(D(:,cell)))/std(D(:,cell));
end
D=D3;

[cleantrials, c]=size(D);

%
% for(trial=1:trials),
% D4(trial,:)=D(trial,:)./mean(D(trial,:));
% end
% D=D4;



subplot(3,2,2)
imagesc(D);
ylabel('Trials');
xlabel('Cells');
title(' STD matrix for all ROIs');
subplot(3,2,4)
CVC=cov(D,1);
imagesc(CVC,clim);
title('unsorted covariance matrix');



l = linkage(CVC, 'ward', 'correlation');

subplot(3,2,6)
% c=cluster(l,'maxclust',4);
% [aa,bb]=sort(c);
CVC2=cov(D(:,bb));
imagesc(CVC2,clim);
eig2 = CVC2;
title('Sorted Covariance matrix')
% colormap(hot)
% colorbar
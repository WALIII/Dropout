
function FS_cellclust(SortedCell)
% Make covariance matirx for imaging data input format: SortedCell(trial,time,cell)
% TG
% modified by WAL3
% d011517

%close all;


figure(); plot(SortedCell(:,:,1)');


startT = 7;
endT = size(SortedCell,2)-5;
cells = size(SortedCell,3);
trials = size(SortedCell,1);



for cell = 1:cells % cells;
for trial = 1:trials % trials;

   % C(i,cell)=(max(ROI_data_cleansed{day}.raw_dat{cell,i})-median(ROI_data_cleansed{day}.raw_dat{cell,i}));
    C(trial,cell)=std(SortedCell(trial,startT:endT,cell));
    C2(trial,cell)=mean(SortedCell(trial,startT:endT,cell));

end;
%C(:,cell)=(C(:,cell)-mean(C(:,cell)))/(std(C(:,cell)));
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
subplot(3,1,1)
imagesc(D);
ylabel('Trials');
xlabel('Cells');
title(' STD matrix for all ROIs');
subplot(3,1,2)
CVC=cov(D,1);
imagesc(CVC);
title('unsorted covariance matrix');
colorbar


l = linkage(CVC, 'average', 'correlation');

subplot(3,1,3)
c=cluster(l,'maxclust',4);
[aa,bb]=sort(c);
CVC2=cov(D(:,bb));
imagesc(CVC2);
title('Sorted Covariance matrix')
% colormap(hot)
colorbar



figure()
RC=zeros(size(D));
for(i=1:cells),
RC(:,i)=D(randperm(cleantrials),i);
end


colorbar
subplot(3,1,1);
imagesc(RC);
ylabel('Trials');
xlabel('Cells');
title('random permutation of STD matrix');
colorbar

subplot(3,1,2);
CVCR=cov(RC);
imagesc(CVCR);
title('covariance');
colorbar


l = linkage(CVCR, 'ward', 'correlation');
subplot(3,1,3)
c=cluster(l,'maxclust',4);
[aa,bb2]=sort(c);
CVCR=cov(RC(:,bb2));
imagesc(CVCR);
title('Sorted covariance');
colorbar

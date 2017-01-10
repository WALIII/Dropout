
function FS_cellclust(SortedCell)

close all;


endT = 30;
cells = size(SortedCell,2);
trials = size(SortedCell{1},1);

for cell = 1:cells % cells;
for i = 1:trials % trials;

   % C(i,cell)=(max(ROI_data_cleansed{day}.raw_dat{cell,i})-median(ROI_data_cleansed{day}.raw_dat{cell,i}));
    C(i,cell)=std(SortedCell{cell}(1:endT,i));
    C2(i,cell)=mean(SortedCell{cell}(1:endT,i));

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
if(q(k)<100),
    D(j,:)=C(k,:);
    D2(j,:)=C2(k,:);
    j=j+1;
end
end


for(i=1:cells),
D3(:,i)=(D(:,i)-mean(D(:,i)))/std(D(:,i));
end
D=D3;

[cleantrials, c]=size(D);


%for(i=1:trials),
%D4(i,:)=D(i,:)./mean(D(i,:));
%end
%D=D4;


figure(2)
subplot(2,1,1)
CVC=cov(C2,1);
imagesc(CVC);
title('unsorted covariance matrix');

subplot(2,1,2)
c=cluster(linkage(CVC),'maxclust',7);
[aa,bb]=sort(c);
CVC2=cov(CVC(:,bb));
imagesc(CVC2);
title('Sorted Covariance matrix')
colorbar



figure()
RC=zeros(size(D));
for(i=1:cells),
RC(:,i)=D(randperm(cleantrials),i);
end

subplot(3,1,1);
imagesc(RC);
title('random permutation of trials');

subplot(3,1,2);
colormap(jet)
CVCR=cov(RC);
imagesc(CVCR);
title('covariance');

subplot(3,1,3)
c=cluster(linkage(CVCR),'maxclust',3);
[aa,bb2]=sort(c);
CVCR=cov(RC(:,bb2));
imagesc(CVCR);
colorbar

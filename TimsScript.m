
function FS_cell_cluster(SortedCells)


figure();

day = 1;

trials=  size(ROI_data_cleansed{day}.filename(:),1);
cells=41;

trials=100;

for cell = 1:cells
for i = 1:trials

   % C(i,cell)=(max(ROI_data_cleansed{day}.raw_dat{cell,i})-median(ROI_data_cleansed{day}.raw_dat{cell,i}));
    C(i,cell)=std(ROI_data_cleansed{day}.raw_dat{cell,i});
    C2(i,cell)=mean(ROI_data_cleansed{day}.raw_dat{cell,i});

end;
%C(:,cell)=(C(:,cell)-mean(C(:,cell)))/(std(C(:,cell)));
end

figure(1)
imagesc(C);

q=sum(C');
j=1;
for(k=1:trials),
if(q(k)<400),
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
colormap(jet)
CVC=cov(D,1);



c=cluster(linkage(CVC),'maxclust',7);
[aa,bb]=sort(c);
CVC2=cov(D(:,bba));
imagesc(CVC2);
colorbar

figure(3)
RC=zeros(size(D));
for(i=1:cells),
RC(:,i)=D(randperm(cleantrials),i);
end


imagesc(RC);
figure(4)
colormap(jet)
CVCR=cov(RC);

% c=cluster(linkage(CVCR),'maxclust',7);
% [aa,bb2]=sort(c);
% CVCR=cov(RC(:,bb2));
% imagesc(CVCR);
% colorbar

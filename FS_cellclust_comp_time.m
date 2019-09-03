
function [eig1,eig2,sorting,output]= FS_cellclust_comp_time(data)
% Make covariance matirx for imaging data input format: data.directed(trial,time,cell)
% TG
% modified by WAL3
% d011517

%close all;


% figure(); plot(data.directed(:,:,1)');

startT = 1;
endT = size(data.directed,2);
cells = size(data.directed,3);
trials = size(data.directed,1);
clim = [-.1 0.6];
maxlag_samps=3;%round(25*.02);

MM_C2 = mean(data.directed(:,startT:endT,:),3);

for cell = 1:cells % cells;
for trial = 1:trials % trials;

   % C(i,cell)=(max(ROI_data_cleansed{day}.raw_dat{cell,i})-median(ROI_data_cleansed{day}.raw_dat{cell,i}));
    C4(trial,cell)=std(data.directed(trial,startT:endT,cell));
    C2(trial,cell)=mean(data.directed(trial,startT:endT,cell));
    C3(trial,cell)=mean(data.directed(trial,startT:endT,cell));

end;
%C(:,cell)=(C(:,cell)-mean(C(:,cell)))/(std(C(:,cell)));
end

% data.total = cat(1, data.directed,data.undirected)
% data.directed = data.directed;
% data.undirected = data.undirected;
AVG_Trace = squeeze(mean(data.all,1));
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


% clean up data
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



% Mean subtraction
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


cells = size(data.undirected,3);
trials = size(data.undirected,1);



for cell = 1:cells % cells;
for trial = 1:trials % trials;

   % C(i,cell)=(max(ROI_data_cleansed{day}.raw_dat{cell,i})-median(ROI_data_cleansed{day}.raw_dat{cell,i}));
    C(trial,cell)=std(data.undirected(trial,startT:endT,cell));
    C2(trial,cell)=mean(data.undirected(trial,startT:endT,cell));

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


% output
etemp1 = eig1;
etemp2 = eig2;

% etemp1(etemp1 ==1) = [];
% etemp2(etemp2 ==1) = [];

output.CVC_U = etemp1;
output.CVC_D = etemp2;
output.mCVC_U = mean((etemp1));
output.mCVC_D = mean((etemp2));

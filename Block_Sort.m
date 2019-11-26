function [out] = Block_Sort(sim_score,DffHeight,ChoppedAvect,DffIntegrate,amplitude_score, ChoppedGcon,cho);
% Plot features from tempScrap.m

% NOTE: this is redundant with Bloack_sort!

% WAL3 07/26/19


%% Split data into boxplots...
Fig_plotting =0; % plot figures

if cho ==1;
disp('sorting by song similarity');
elseif cho ==2;
disp('sorting by Dff height');
elseif cho ==3;
disp('sorting by warping')
end


figure();
trials = size(sim_score,2);
for ROI_Peak = 1:size(ChoppedGcon,4); % for every song segment
    clf
A = zscore(sim_score(ROI_Peak,:));
B = zscore(DffHeight(1:trials,ROI_Peak));
C = abs(zscore(ChoppedAvect(1:trials,ROI_Peak)-nanmean(ChoppedAvect(1:trials,ROI_Peak)))); % sound difference/length
%C = ChoppedAvect(1:trials,ROI_Peak);
D = zscore(DffIntegrate(1:trials,ROI_Peak));
E = zscore(amplitude_score(ROI_Peak,:));
% consolidate data..
Aa(:,ROI_Peak) = A;
Ba(:,ROI_Peak) = B;
Ca(:,ROI_Peak) = C;
Da(:,ROI_Peak) = D;
Ea(:,ROI_Peak) = E;
%C = abs(zscore(ChoppedAvect(1:400,cl)));
% B = (B - min(B)) / ( max(B) - min(B) );\



siz = 4; % cut data into even blocks, in time, based on the time vect

if cho ==1;
[Bi,I] = sort(A');
g = floor(size(A',1)/siz);
elseif cho ==2;
[Bi,I] = sort(B);
g = floor(size(B,1)/siz);
elseif cho ==3;
[Bi,I] = sort(C);
g = floor(size(C,1)/siz);
end

for i = 1:(siz-1); %val * group
    if i ==1;

Ahl(:,i) = A(I(1:g));
Bhl(:,i) = B(I(1:g));
Chl(:,i) = C(I(1:g));
Dhl(:,i) = D(I(1:g));
Ehl(:,i) = E(I(1:g));
    else

Chl(:,i) = C(I(g*i+1:g*(i+1)));
Ahl(:,i) = A(I(g*i+1:g*(i+1)));
Bhl(:,i) = B(I(g*i+1:g*(i+1)));
Dhl(:,i) = D(I(g*i+1:g*(i+1)));
Ehl(:,i) = E(I(g*i+1:g*(i+1)));
    end
end

% mean of the dff for each time section ( eventually, every dot is the mean
% ROI df/f for the 1-33%, 34-67% and 68-99% most streached songs)


At(ROI_Peak,:) = mean(Ahl,1); % mean dff for this segment
Bt(ROI_Peak,:) = mean(Bhl,1);
Ct(ROI_Peak,:) = mean(Chl,1);
Dt(ROI_Peak,:) = mean(Dhl,1);
Et(ROI_Peak,:) = mean(Ehl,1);


% all values:
% for iii = 1:3
% totCt(cl,:,iii) = Chl(:,iii);
% totAt(cl,:,iii) = Ahl(:,iii);
% totDt(cl,:,iii) = Dhl(:,iii);
% end
% Ct(cl,:) = Chl(:); % mean across song segment
% At(cl,:) = Ahl(:);
% Dt(cl,:) = Dhl(:);

% subplot(1,2,2);
% boxplot(Chl,'Notch','on','Labels',{'mu = 5','mu = 6'});
% pause()

end
%
% At = Ct;
% figure(); plot(zeros(size(At(:,1))),At(:,1)-At(:,1),'*');
% hold on;
% plot(ones(size(At(:,1))),At(:,2)-At(:,1),'*');
% line([zeros(size(At(:,1))),ones(size(At(:,1)))],[At(:,1)-At(:,1),At(:,2)-At(:,1)])

% Normalize data- output is mean dff (across the quartile) for each
% 'event'



if Fig_plotting ==1;
% FIgures



NDATA = mat2gray(Dt);
NDATA2 = mat2gray(At);
NDATA3 = mat2gray(Et);

figure();
boxplot(NDATA,'Notch','on');
title('df/f as a function of applied time warping');
ylabel('normalized df/f');

figure();
boxplot(NDATA2,'Notch','on');
title('Normalized Song Similarity as a function of warping');
ylabel('Song Similarity');

%
figure();
boxplot(NDATA3,'Notch','on');
title('Normalized Song Amplitude as a function of warping');
ylabel('Song Similarity');
%

figure();
subplot(131);
plotSpread(NDATA);
title('df/f as a function of applied time warping');
subplot(132);
plotSpread(NDATA2);
title('Normalized Song Similarity as a function of warping');
subplot(133);
plotSpread(NDATA3);
title('Normalized Song Amplitude as a function of warping');


% Song amplitude vs Df/f
figure();
hold on;
% col = ['r','g','b','c']
% for ix = 1:4;
    hold on;
% plot(((Dt(:,ix))),((Ct(:,ix))),'o','Color',col(ix));
clear ttt2 ttt toplot toplot2
figure(); plot(mat2gray(Ea(:)),mat2gray(Da(:)),'o');
test1 = mat2gray(Da(:));
test2 = mat2gray(Ba(:));
test3 = mat2gray(Ea(:));
counter = 1;
for i = 0:.1:1;
    toplot{counter} = test1(find(test3>i & test3<(i+1)));
    toplot2{counter} = test2(find(test3>i & test3<(i+1)));


    Bxv(:,counter) = mean(toplot{counter});
    err(:,counter) = std(toplot{counter})/sqrt(length(toplot{counter}));

    Bxv2(:,counter) = mean(toplot2{counter});
    err2(:,counter) = std(toplot2{counter})/sqrt(length(toplot2{counter}));


counter = counter+1;
end
figure();
hold on;
errorbar(1:length(Bxv),Bxv,err)
errorbar(1:length(Bxv2),Bxv2,err2)
end

out.At = At;
out.Bt = Bt;
out.Ct = Ct;
out.Dt = Dt;
out.Et = Et;

% hold on;
% end

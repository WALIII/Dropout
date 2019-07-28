
function [out] = tempScrap(s,c,Gconsensus3,D2,t,varargin);
%

% function for taking CaIM data and checking the effect of time warping % cut out df/f differences at infered burst moments\

% Default inputs
Fig_Plotting = 0; % plot figures for each run///
    counter = 1;
    fs = 48000;
    % bounds
    time_window = 0.001;% 33 ms
    fr = 30; % 25 fps
    frames = 5;
% Build windows ( ~ 1 frame)
    mx = 100;
    mn = 100;%time_window/mean(diff(aVect));
    thresh = 0.1;


    %% Custom Paramaters
nparams=length(varargin);

if mod(nparams,2)>0
    error('Parameters must be specified as parameter/value pairs');
end

for i=1:2:nparams
    switch lower(varargin{i})
        case 'fs'
            fs=varargin{i+1};
        case 'fr' % Firing rate
            fr=varargin{i+1};
        case 'frames'
            frames=varargin{i+1};
        case 'mx'
            mx=varargin{i+1};
            mn=varargin{i+1};
       case 'thresh'
           thresh=varargin{i+1};

    end
end




% Get audio difference vector:
    interval = median(diff(D2.warped_time(1,:,1)));
    WT = D2.warped_time(:,(1/interval)*0.25:end-(1/interval)*0.5,:);
% Start time at zero:
    WT2(1,:,:) = WT(1,:,:)-(WT(1,1,:));
    WT2(2,:,:) = WT(2,:,:)-(WT(2,1,:));
% Make difference vector:
    WT3 = squeeze(WT2(1,:,:)-WT2(2,:,:));
    aVect = (1:size(WT3))*interval;
    clear WT2 WT% free up memory




% Get Peaks in Dff
    for i = 1:size(s,2); % for every cell
      clear idx sidx Tidx Gidx
      [pk,idx] = findpeaks(s(:,i),'MinPeakProminence',thresh); % find spike  frame

      for ii = 1:size(idx);
        sidx = idx(ii)./fr; % convert spike to 'time'
        [cx Gidx] = min(abs(sidx-(t))); % find the closest index into the Gconsensus
        [ax Aidx] = min(abs(sidx-(aVect))); % find the closest index into the Gconsensus
        %[Tx Tidx] = min(abs(sidx-(aVect))); % find the closest index into the audio

        try
            %[c Tidx] = min(abs(sidx+0.25-(D2.warped_time(2,:)))); % find the closest index into the Time Vector
        ChoppedGcon(:,:,:,counter) = Gconsensus3{1}(:,Gidx-mx:Gidx,:);
        ChoppedAvect(:,counter) = sum(diff(WT3(Aidx-mn:Aidx,:)-WT3(Aidx-mn,:))); % get sum of timing diffetence in this window
        AudioVect(:,:,counter) = D2.song_w(:,(0.25*fs+sidx*fs-+0.10*fs):(0.25*fs+sidx*fs)+0.033*fs); % get audio chopped out...
        catch

            disp('cutting close on the song...');
        continue
        end

        %f1 = D2.warped_time(:,Tidx-20:Tidx+10);
        %ChoppedSongTime(:,counter) = (f1(1,1)-f1(1,end))-  (f1(2,1)-f1(2,end));
        try
          DffHeight(:,counter) = max(squeeze(D2.unsorted(:,idx(ii):idx(ii)+frames,i))')-min(squeeze(D2.unsorted(:,:,i))');

                for a = 1:size(D2.unsorted(:,idx(ii):idx(ii)+frames,i),1);
                   x1 = (squeeze(D2.unsorted(a,idx(ii):idx(ii)+frames,i))'-min(squeeze(D2.unsorted(a,:,i))'));
                   DffIntegrate(a,counter) = trapz(1:length(x1),x1);
                end
        catch
          disp('too close to the end, no pad...');
          DffHeight(:,counter) = max(squeeze(D2.unsorted(:,idx(ii):end,i))')-min(squeeze(D2.unsorted(:,:,i))');
                 for a = 1:size(D2.unsorted(:,idx(ii):end,i),1);
                    x1 = (squeeze(D2.unsorted(a,idx(ii):end,i))'-min(squeeze(D2.unsorted(a,:,i))'));
                    DffIntegrate(a,counter) = trapz(1:length(x1),x1);
                   end
          end
       GIndex(1,counter) = i;
       GIndex(2,counter) = ii;
        counter = counter+1;
      end
    end


disp( 'Getting the Similarity Score');


    % Sim_score = (ID'd peak * all_song_spectrograms)
for ii = 1:size(ChoppedGcon,4); % for every example group
  Mean_c2 = squeeze(mean(ChoppedGcon(:,:,:,ii),3)); % get the mean for this example
  Mean_amp = mean(squeeze(mean(abs(AudioVect(:,:,ii)),2)));
  for i = 1:size(ChoppedGcon,3) % calc the sim score
      %sim_score(i)=norm(consensus(:,:,i).*Mean_c)/sqrt(norm(consensus(:,:,i)).*norm(Mean_c));
      sim_score(ii,i)= sum(sum(squeeze(ChoppedGcon(:,:,i,ii)).*Mean_c2))./sqrt(sum(sum(squeeze(ChoppedGcon(:,:,i,ii)).^2)).*sum(sum(Mean_c2.^2))+.1);
      amplitude_score(ii,i) = mean(squeeze(abs(AudioVect(:,i,ii))))-Mean_amp;
      %vector_score(:,i) =  (sum(consensus(:,:,i).*Mean_c2))./sqrt((sum(consensus(:,:,i).^2)).*(sum(Mean_c2.^2)));
 if sum(sum(isnan(sim_score))) >1;
     sim_score(isnan(sim_score))=0;
     disp('warning! Nans are afoot');
 end



  end
end


out.sim_score = sim_score;
out.DffHeight = DffHeight;
out.ChoppedAvect = ChoppedAvect;
out.DffIntegrate = DffIntegrate;
out.amplitude_score = amplitude_score;
out.ChoppedGcon = ChoppedGcon;


% Plot
if Fig_Plotting ==1;
% Split data into boxplots...
figure();

clear g I Chl Ahl At Ct
trials = size(sim_score,2);
for ROI_Peak = 1:size(ChoppedGcon,4); % for every song segment
    clf
A = zscore(sim_score(ROI_Peak,:));
B = zscore(DffHeight(1:trials,ROI_Peak))-nanmin(zscore(DffHeight(1:trials,ROI_Peak)));
C = abs(ChoppedAvect(1:trials,ROI_Peak)-nanmean(ChoppedAvect(1:trials,ROI_Peak))); % sound difference
D = zscore(DffIntegrate(1:trials,ROI_Peak))-nanmin(zscore(DffHeight(1:trials,ROI_Peak)));
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
[Bi,I] = sort(C);
g = floor(size(C,1)/siz);

for i = 1:(siz-1); %val * group
    if i ==1;

Ahl(:,i) = A(I(1:g));
Bhl(:,i) = B(I(1:g));
Chl(:,i) = C(I(1:g));
Dhl(:,i) = D(I(1:g));
Ehl(:,i) = E(I(1:g));
SplitGcon(:,:,i,ROI_Peak) = mean(squeeze(ChoppedGcon(:,:,I(1:g),ROI_Peak)),3);
    else

Chl(:,i) = C(I(g*i+1:g*(i+1)));
Ahl(:,i) = A(I(g*i+1:g*(i+1)));
Bhl(:,i) = B(I(g*i+1:g*(i+1)));
Dhl(:,i) = D(I(g*i+1:g*(i+1)));
Ehl(:,i) = E(I(g*i+1:g*(i+1)));
SplitGcon(:,:,i,ROI_Peak) = mean(squeeze(ChoppedGcon(:,:,I(g*i+1:g*(i+1)),ROI_Peak)),3);

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


figure();
boxplot(NDATA3,'Notch','on');
title('Normalized Song Amplitude as a function of warping');
ylabel('Song Similarity');


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
%plot(((Dt(:,ix))),((Ct(:,ix))),'o','Color',col(ix));
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
% figure();
% hold on;
% errorbar(1:length(Bxv),Bxv,err)
% errorbar(1:length(Bxv2),Bxv2,err2)


%
% hold on;
% end


out.dff = NDATA; % dff
out.int = NDATA2; % integration
out.int = NDATA3; % Amplitude
out.B = Ba(:);
out.C = Ca(:);
out.A = Aa(:);
out.D = Da(:);
end

% for iii = 1:3;
% aa = totAt(:,:,iii);
% aa1(:,iii) = aa(:);
% ad = totDt(:,:,iii);
% ad1(:,iii) = ad(:);
% end

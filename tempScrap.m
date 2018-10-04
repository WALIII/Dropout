
function [out] = tempScrap(s,c,Gconsensus3,D2,t);
% 

% function for taking CaIM data and checking the effect of time warping

    % cut out df/f differences at infered burst moments\
    counter = 1;
    % bounds
    mx = 100;
    mn =  20;
    fr = 25 % 25 fps
    
% Get audio difference vector: 
interval = median(diff(D2.warped_time(1,:,1)));
WT = D2.warped_time(:,(1/interval)*0.01:end-(1/interval)*0.01,:);
% Start time at zero:
WT2(1,:,:) = WT(1,:,:)-(WT(1,1,:));
WT2(2,:,:) = WT(2,:,:)-(WT(2,1,:));
% Make difference vector:
WT3 = squeeze(WT2(1,:,:)-WT2(2,:,:));
aVect = (1:size(WT3))*interval;
clear WT2 WT% free up memory



    for i = 1: 20; % for every cell
      clear idx sidx Tidx Gidx
      [pk,idx] = findpeaks(s(:,i)); % find spike  frame

      for ii = 1:size(idx);
        sidx = idx(ii)./fr; % convert spike to 'time'
        [cx Gidx] = min(abs(sidx-(t))); % find the closest index into the Gconsensus
        [ax Aidx] = min(abs(sidx-(aVect))); % find the closest index into the Gconsensus

        try
            %[c Tidx] = min(abs(sidx+0.25-(D2.warped_time(2,:)))); % find the closest index into the Time Vector
        ChoppedGcon(:,:,:,counter) = Gconsensus3{1}(:,Gidx-150:Gidx,:);
        ChoppedAvect(:,counter) = sum(diff(WT3(Aidx-20:Aidx,:)-WT3(Aidx-20,:))); % get sum of timing diffetence in this window
        catch
            
            disp('cutting close on the song...');
        continue
        end

        %f1 = D2.warped_time(:,Tidx-20:Tidx+10);
        %ChoppedSongTime(:,counter) = (f1(1,1)-f1(1,end))-  (f1(2,1)-f1(2,end));
        try
          DffHeight(:,counter) = max(squeeze(D2.unsorted(:,idx(ii):idx(ii)+10,i))')-min(squeeze(D2.unsorted(:,:,i))');
          
                for a = 1:size(D2.unsorted(:,idx(ii):idx(ii)+10,i),1);
                   x1 = (squeeze(D2.unsorted(a,idx(ii):idx(ii)+10,i))'-min(squeeze(D2.unsorted(a,:,i))'));
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
  for i = 1:size(ChoppedGcon,3) % calc the sim score
      %sim_score(i)=norm(consensus(:,:,i).*Mean_c)/sqrt(norm(consensus(:,:,i)).*norm(Mean_c));
      sim_score(ii,i)= sum(sum(squeeze(ChoppedGcon(:,:,i,ii)).*Mean_c2))./sqrt(sum(sum(squeeze(ChoppedGcon(:,:,i,ii)).^2)).*sum(sum(Mean_c2.^2)));
      %vector_score(:,i) =  (sum(consensus(:,:,i).*Mean_c2))./sqrt((sum(consensus(:,:,i).^2)).*(sum(Mean_c2.^2)));
  end
end




% Plot

%% Split data into boxplots...
figure(); 

clear g I Chl Ahl At Ct
sz = size(sim_score,2);
for cl = 1:size(ChoppedGcon,4); % for every song segment
    clf
A = zscore(sim_score(cl,:));
B = zscore(DffHeight(1:sz,cl));%-nanmean(DffHeight(1:500,cl));
C = abs(ChoppedAvect(1:sz,cl)-nanmean(ChoppedAvect(1:sz,cl)));
D = zscore(DffIntegrate(1:sz,cl));%-nanmean(DffHeight(1:500,cl));

% consolidate data..
Aa(:,cl) = A;
Ba(:,cl) = B;
Ca(:,cl) = C;
Da(:,cl) = D;
%C = abs(zscore(ChoppedAvect(1:400,cl)));

% B = (B - min(B)) / ( max(B) - min(B) );


siz = 4; % cut data into even blocks, in time, based on the time vect
[Bi,I] = sort(C);
g = floor(size(C,1)/siz);

for i = 1:(siz-1); %val * group
    if i ==1;
Chl(:,i) = B(I(1:g));
Ahl(:,i) = A(I(1:g));
Dhl(:,i) = D(I(1:g));
    else

Chl(:,i) = B(I(g*i+1:g*(i+1)));
Ahl(:,i) = A(I(g*i+1:g*(i+1)));
Dhl(:,i) = D(I(g*i+1:g*(i+1)));
    end
end

% mean of the dff for each time section ( eventually, every dot is the mean
% ROI df/f for the 1-33%, 34-67% and 68-99% most streached songs)

Ct(cl,:) = mean(Chl,1); 
At(cl,:) = mean(Ahl,1);
Dt(cl,:) = mean(Dhl,1);

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
NDATA = mat2gray(Ct);
NDATA2 = mat2gray(Dt);
figure();
boxplot(NDATA,'Notch','on');
title('df/f as a function of applied time warping');
ylabel('normalized df/f');

figure();
boxplot(NDATA2,'Notch','on');
title('Normalized Song Similarity as a function of warping');
ylabel('Song Similarity');

figure(); 
subplot(121);
plotSpread(NDATA);
title('df/f as a function of applied time warping');
subplot(122);
plotSpread(NDATA2);
title('Normalized Song Similarity as a function of warping');


out.dff = NDATA;
out.int = NDATA2;
out.B = Ba(:);
out.C = Ca(:);
out.A = Aa(:);
out.D = Da(:);

% for iii = 1:3;
% aa = totAt(:,:,iii);
% aa1(:,iii) = aa(:);
% ad = totDt(:,:,iii);
% ad1(:,iii) = ad(:);
% end


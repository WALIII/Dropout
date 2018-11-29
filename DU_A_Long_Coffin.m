% DU_a_Long_Coffin

% Final figure analysis for the Directed/Undirected paper.. can we find, through regression analysis,
% Any correlation between the song and the Calcium data?




%%%%[ Use Longitudinal Data ] %%%%

% Take data that is already formatted, and run a regression on it

% Load in data, and get the relevant features.

%% INSCOPIX DATA
%[Gconsensus3,CalciumDat,WARPED_TIME,WARPED_audio,idex,f,t] =  Inscopix_regression(ROI_data_cleansed);

% FREEDOMSCOPE DATA
[FS_ROI_Data] = FS_regression_preprocessing() % for new, FS data..., run in folder with extrated data

[FS_ROI_Data] = FS_regression_preprocessing_manual();  % for already extracted data


% Streatch data...
D2 = WarpRegress(FS_ROI_Data);

% Get SDI
% Check Spectrogram:
fs = 48000;
  figure(); FS_Spectrogram(D2.song_r(1,fs*0.25:end-(fs*0.50)),fs);

% Get Gconsensus
  disp(' Getting Gcon');
  fs = 48000;
  [Gconsensus3,f,t] = CY_Get_Consensus(D2.song_w(:,fs*0.25:end-(fs*0.50))',48000);
% get warped time on same timescale..
  % interval = median(diff(D2.warped_time(1,:,1)));

  % WT = D2.warped_time(:,(1/interval)*0.25:end-(1/interval)*0.75,:);
% % Start time at zero:
%     WT2(1,:,:) = WT(1,:,:)-(WT(1,1,:));
%     WT2(2,:,:) = WT(2,:,:)-(WT(2,1,:));
%
% % Make difference vector:
%     WT3 = squeeze(WT2(1,:,:)-WT2(2,:,:));
% % Plot the time vector
%   figure(); plot((1:size(WT3))*interval,WT3);


% Identify peaks and putaive spike times in Ca data usein deconvolveCa.m, to constrict where to look
% For regression. Repeat for every day independantly.
  for i = 1:size(D2.unsorted,3);
[    c(:,i), s(:,i), options(:,i)] = deconvolveCa(mean(D2.unsorted(:,:,i),1)-min(mean(D2.unsorted(:,:,i),1)));
  end

% check it
  figure();
    for i = 1: 40;
      hold on;
      plot(mean(D2.unsorted(:,:,i),1)); hold on; plot(c(:,i)); plot(s(:,i));
      pause();
      clf;
    end


% Make boxplots ( work in progress...)
% TO DO: we want the 'height' as well as area under curve...
tempScrap(s,c,Gconsensus3,D2,t);




  clear DffHeight ChoppedGcon
      % cut out df/f differences at infered burst moments\
      counter = 1;
      % bounds
      mx = 100;
      mn =  20;
      for i = 1: 40; % for every cell
        clear idx sidx Tidx Gidx
        [pk,idx] = findpeaks(s(:,i)); % find spike  frame

        for ii = 1:size(idx);
          sidx = idx(ii)./30; % convert spike to 'time'
          [cx Gidx] = min(abs(sidx-(t+0.25))); % find the closest index into the Gconsensus

          try
              %[c Tidx] = min(abs(sidx+0.25-(D2.warped_time(2,:)))); % find the closest index into the Time Vector
          ChoppedGcon(:,:,:,counter) = Gconsensus3{1}(:,Gidx-30:Gidx+30,:);

          catch

              disp('cutting close on the song...');
          continue
          end

          %f1 = D2.warped_time(:,Tidx-20:Tidx+10);
          %ChoppedSongTime(:,counter) = (f1(1,1)-f1(1,end))-  (f1(2,1)-f1(2,end));
          try
            DffHeight(:,counter) = max(squeeze(D2.unsorted(:,idx(ii):idx(ii)+10,i))');
          catch
            disp('too close to the end, no pad...');
            DffHeight(:,counter) = max(squeeze(D2.unsorted(:,idx(ii):end,i))');
          end
         GIndex(1,counter) = i;
         GIndex(2,counter) = ii;

          counter = counter+1;


        end
      end



      % Sim_score = (ID'd peak * all_song_spectrograms)
  for ii = 1:size(ChoppedGcon,4); % for every example group
    Mean_c2 = squeeze(mean(ChoppedGcon(:,:,:,ii),3)); % get the mean for this example
    for i = 1:size(ChoppedGcon,3) % calc the sim score
        %sim_score(i)=norm(consensus(:,:,i).*Mean_c)/sqrt(norm(consensus(:,:,i)).*norm(Mean_c));
        sim_score(ii,i)= sum(sum(squeeze(ChoppedGcon(:,:,i,ii)).*Mean_c2))./sqrt(sum(sum(squeeze(ChoppedGcon(:,:,i,ii)).^2)).*sum(sum(Mean_c2.^2)));
        %vector_score(:,i) =  (sum(consensus(:,:,i).*Mean_c2))./sqrt((sum(consensus(:,:,i).^2)).*(sum(Mean_c2.^2)));
    end
  end



  %
  figure();

  for cl = 1:size(ChoppedGcon,4)
      clf
  A = sim_score(cl,:)-nanmean(sim_score(cl,:));
  B = DffHeight(1:500,cl)-nanmean(DffHeight(1:500,cl));
  subplot(121)
  plot(A,B,'*');
  lm = fitlm(A,B,'linear')
  title(['Cell ', num2str(cl)]);
  b = find(A>0);
  b2 = b;
  b3{cl} = b2;
  b = find(A<0);
  b2 = b;
  b4{cl} = b2;
  subplot(122)
  plot(mean(D2.unsorted(:,:,GIndex(1,cl)),1)); hold on;  plot(s(:,cl));

  pause()

  end



   X2 = mean(Gconsensus3{1}(:,:,b3{5}),3);
   X1 = mean(Gconsensus3{1}(:,:,b4{5}),3);
   figure(); XMASS_song(X1,X2,X1);





% Are there any correlations across days in the changes in spectorgrams? Do these match changes in Ca?
    % Analyis 1: Across days, are there noticeable differences in song? Where to they occur?
















%% EXTRA ANALYSIS ( using the directed undirected dataset)
% Load data

% Get audio Vectors, and index
[audioVect,audioVect2,Index] =  DirUndir_Compare02(song_r,align,TEMPLATE);

% extract calcium data
[data] = FS_Data(calcium,align,Motif_ind,0,32);

% Get the concensus contour ( SDI)
[Gconsensus,f,t] = CY_Get_Consensus(audioVect2);

% find zeros, and remove them...
excl = find(Index{1} ==0)

data.ind_sort = data.raw_unsorted;
data.ind_sort(excl,:,:) = [];

% make a chance level sort
[Rerr, XMerr] = scrap_sort_gcon(Gconsensus);

%
RHO_Compare

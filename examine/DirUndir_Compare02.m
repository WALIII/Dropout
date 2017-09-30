%DirUndir_Compare02

% streatch Wavs and calcium


counter = 1;
for i = 1: size(song_r,1)
% WAVcell{1}{counter} = song_r(i,(align-5)/25*48000:(5+align)/25*48000+size(TEMPLATE,1))';
WAVcell{1}{counter} = song_r(i,(align)/25*48000:(align+25)/25*48000)';

counter = counter+ 1;
end
counter = 1;
% for i = rule2
% WAVcell{2}{counter} = song_r(i,align/25*48000-10000:align/25*48000+size(TEMPLATE,1)+10000)';
% counter = counter+1;
% end

% Y = cat(1,zeros(1000,1), TEMPLATE, zeros(1000,1)); % add zeros to pad

Y = TEMPLATE; % add zeros to pad
[WARPED_TIME, WARPED_audio, Index,startT,endT] = FS_PreMotor_Warp(WAVcell,Y);



%% Design a bandpass filter that filters out between 700 to 12000 Hz
% fs = 48000;
% n = 7;
% beginFreq = 700 / (fs/2);
% endFreq = 12000 / (fs/2);
% [b,a]= butter(n, [beginFreq, endFreq], 'bandpass');

%% Filter the signal
% Consensus
% Spectral Density Image
% counter = 1;
% iii = 1;
% [Gconsensus{iii},F,T] = CY_Get_Consensus(WARPED_audio{1});
% for ii = 1:size(WARPED_audio{iii},2)
% [IMAGE(:,:,ii), T2,F2]= FS_Spectrogram(WARPED_audio{iii}(:,ii),48000);
% fOut = filter(b, a, WARPED_audio{iii}(:,ii));
% audioVect(:,counter) = downsample(tsmovavg(rms(abs(fOut),2),'s',500,1),100);
% audioVectT(:,counter) = fOut;
% counter = counter+1;
% end

% audioVect(isnan(audioVect)) = 0;

% TO DO implement rules here.

% figure(); imagesc(zscore(audioVect)');
% figure(); hold on; plot(zscore(audioVect(:,1:size(idx1,1))),'m');  plot(zscore(audioVect(:,size(idx1,1)+1:size(idx1,1)+size(idx2,1)-1)),'g');


% TO DO: Add data pruning step ( filter) ( audio pop?)  
% D{1} = audioVect(:,1:size(idx1,1));
% D{2} = audioVect(:,size(idx1,1)+1:size(idx1,1)+size(idx2,1)-1);
% figure(); scrapPlot(D);



% Get Average consensus images, and plot them!
% im1 = mean(Gconsensus{1}{1},3);
% im2 = mean(Gconsensus{2}{1},3);
% im3 = mean(IMAGE{1},3);
% im4 = mean(IMAGE{2},3);

% figure();
% XMASS_song(im2(:,:),im1(:,:),im2(:,:),F,T,[0.0001 0.1] );
% figure();
% XMASS_song(im3(:,:),im4(:,:),im3(:,:),F2,T2, [0.0001 0.6]);




% Sim Score
%[sim_score, vector_score, A_diff,S_diff] = FS_PreMotor_FeaturePlot(WARPED_TIME,WARPED_audio,Gconsensus,c_agg)

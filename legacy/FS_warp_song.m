function [WARPED_TIME_u, WARPED_TIME_d, WARPED_audio_u,WARPED_audio_d,Index,GG2_d,GG2_u] = FS_warp_song(WAV_d, WAV_u,template)
% FS_warp_song.m

% For getting info on dynamic time warping of song data.

% WALIII
% 04.30.17

% Use:
% >> WAV = CY_Get_wav ( in _manclust folders for aquiring aligned songs)
% Needs: FS_Spectrogam.m

% Last step is to use CY_Get_Cosensus:
% >> [Gconsensus_d,F,T] = CY_Get_Consensus(WARPED_audio_d)
% >> [Gconsensus_u,F,T] = CY_Get_Consensus(WARPED_audio_u)

% im1 = mean(Gconsensus_d{1},3);
% im2 = mean(Gconsensus_u{1},3);
% XMASS_song(flipdim(im1(:,:),1),flipdim(im2(:,:),1),flipdim(im2(:,:),1));

counter = 1;
fs = 48000; % sampling rate
% template = WAV_d{5}(0.25*fs:end-0.75*fs); % pick a song to be the template
% template = WAV_d{5}(0.25*fs:end-0.75*fs); % pick a song to be the template


%directed
for i = 1:size(WAV_d,2);
    try 
[song_start, song_end, score_d(counter,:)] = find_audio(WAV_d{i}, template, fs, 'match_single', true,'constrain_length', 0.25); 
[WARPED_TIME_d{counter} WARPED_audio_d(:,counter)]  = warp_audio(WAV_d{i}(song_start*fs:song_end*fs,:), template, fs,[]);

GG_d = WARPED_TIME_d{counter}(1,:)-WARPED_TIME_d{counter}(2,:); %differences in timing
GG2_d(counter,:) = diff(GG_d); % Take the derivative of the vector, to get moments of change
   counter = counter+1;
Index(i,1) = i;
catch
    disp('Pass')
Index(i,1) = 0; 
end;
end

counter = 1;
%undirected
for i = 1:size(WAV_u,2);
try
[song_start, song_end, score_u(counter,:)] = find_audio(WAV_u{i}, template, fs, 'match_single', true,'constrain_length', 0.25);
[WARPED_TIME_u{counter} WARPED_audio_u(:,counter)]  = warp_audio(WAV_u{i}(song_start*fs:song_end*fs,:), template, fs,[]);

GG_u = WARPED_TIME_u{counter}(1,:)-WARPED_TIME_u{counter}(2,:);
GG2_u(counter,:) = diff(GG_u);
counter = counter+1;
Index(i,2) = i;
catch
    disp('Pass')
Index(i,2) = 0; 
end

end;








nn = 10;
%directed
GG3_u = mean(GG2_u);
GG4_u = tsmovavg(abs(GG3_u),'s',nn);
GG4_u = [zeros(1,nn/2) GG4_u(nn:end) zeros(1,nn/2-1)];

%undirected
GG3_d = mean(GG2_d);
GG4_d = tsmovavg(abs(GG3_d),'s',nn);
GG4_d = [zeros(1,nn/2) GG4_d(nn:end) zeros(1,nn/2-1)];


FS_Spectrogram(WARPED_audio_u(:,1),48000); hold on; 
plot(WARPED_TIME_d{1}(1,1:end-1),zscore(abs(GG4_d))*2000,'g','LineWidth',3);
plot(WARPED_TIME_u{1}(1,1:end-1),zscore(abs(GG4_u))*2000,'m','LineWidth',3);


%


% figure();
% 
% subplot(1,2,1)
% hold on;
% plot(WAV_d{i}(song_start*fs:song_end*fs,:))
% plot(template);
% title('unwarped')
% 
% 
% subplot(1,2,2)
% hold on;
% plot(WARPED_audio_u)
% plot(template);
% 
% title('warped')
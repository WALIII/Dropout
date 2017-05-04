function [GG3_u,GG3_d, Ca_score_u, Ca_score_d] = FS_Comparison(roi_ave,directed,undirected,motif)
% FS_Compariosn.m

% d050217
% WAL3

% Compare droppout data ( indireced v undirected) to song similarity,
% in both song duration ( time warping), and spectral features.



% Format the ROI data appropritaly, seperate by motif:
disp( ' Formatting Data...')
[data] = FS_Format_Dropout(roi_ave, directed,undirected, motif);

% Format WAV data apropriately, seperate by motif
disp( ' Formatting WAV Data...')
[WAV_d WAV_u] = FS_Sep_Audio(roi_ave, directed,undirected, motif);

% Warp Song
disp( ' Warping WAV Data...')
[WARPED_TIME_u, WARPED_TIME_d, WARPED_audio_u,WARPED_audio_d,Index,GG2_d,GG2_u] = FS_warp_song(WAV_d, WAV_u);


% Compare Calcium data, taking the Xcorr ( Dot product) of each cell to average
% trace. format = data.diretected(trials,samples,cells)
disp( ' Comparing Calcium similarity Scores ...')
maxlag_samps=round(25*.02);
Y = Index(:,1);
Y( Y==0 )=[];
counter = 1;

% average across all data:
data.total = cat(1, data.directed,data.undirected)

%[DIRECTED]
AVG_Trace = squeeze(mean(data.total,1));
for cell = 1:size(data.directed,3)
  for trial = Y';
    Ca_Xcorr_d{counter}(cell) = max(xcorr(data.directed(trial,:,cell),AVG_Trace(:,cell),maxlag_samps,'coeff'))/max(xcorr(data.directed(trial,:,cell),(data.directed(trial,:,cell)),maxlag_samps,'coeff'));
  counter = counter+1;
  end
  counter = 1;
end

counter = 1;
 % Compare matrix of Ca traces the average matrix of ca traces
for i = Y';
    Avg_Ca_xcorr{counter} = mean(Ca_Xcorr_d{counter});
    Ca_score_d(counter)=norm(squeeze(data.directed(i,:,:)).*AVG_Trace)/sqrt(norm(squeeze(data.directed(i,:,:)).*norm(AVG_Trace)));
counter = counter+1;
end

Y = Index(:,2);
Y( Y==0 )=[];
counter = 1;
%[UNDIRECTED]
for cell = 1:size(data.undirected,3)
  for trial = Y';
    Ca_Xcorr_u{counter}(cell) = max(xcorr(data.undirected(trial,:,cell),AVG_Trace(:,cell),maxlag_samps,'coeff'))/max(xcorr(data.undirected(trial,:,cell),(data.undirected(trial,:,cell)),maxlag_samps,'coeff'));
  counter = counter+1;
  end
  counter = 1;
end
counter = 1;
clear Avg_Ca_xcorr;
 % Compare matrix of Ca traces the average matrix of ca traces
for i = Y';
    Avg_Ca_xcorr{counter} = mean(Ca_Xcorr_u{counter});
    Ca_score_u(counter)=norm(squeeze(data.undirected(i,:,:)).*AVG_Trace)/sqrt(norm(squeeze(data.undirected(i,:,:)).*norm(AVG_Trace)));
counter = counter+1;
end



%Plot data
GG3_u = (mean(abs(GG2_u),2));
GG3_d = (mean(abs(GG2_d),2));

figure(); plot(GG3_u,Ca_score_u,'m*'); hold on; plot(GG3_d,Ca_score_d,'g*');

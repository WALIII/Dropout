function [DataD, DataU] = DirUndir_wav(WAVd,WAVu,TEMPLATE);
% Compaer Audio  data from Directed and Undirected song.

for ii = 1:2
    
    if ii ==1
        WAV6 = WAVd;
        disp('Processing Directed song');
    else
        WAV6 = WAVu;
        disp('Processing unDirected song');
    end
    
% Align Spectrograms
[song, song_r, align,Motif_ind]= FS_Premotor_WavSort(WAV6,TEMPLATE(1:end));

% Check Alignment
% FS_Premotor_WavPlot(song,align)

% Sort motifs
[WAVcell] =  FS_Wav_sort(Motif_ind,align,song_r);

% Warp Time
[WARPED_TIME, WARPED_audio, Index] = FS_PreMotor_Warp(WAVcell,TEMPLATE);

% Spectral Density Image
for iii = 1:size(WARPED_audio,2)
[Gconsensus{i},F,T] = CY_Get_Consensus(WARPED_audio{i});
end

% Get Average consensus images, and plot them!
im1 = mean(Gconsensus{1}{1},3);
im2 = mean(Gconsensus{4}{1},3);
im3 = mean(Gconsensus{3}{1},3);
XMASS_song(im1(:,:),im2(:,:),im3(:,:),F,T);



    if ii ==1
DataD.WARPED_TIME = WARPED_TIME;
DataD.WARPED_audio = WARPED_audio;
DataD.Gconsensus = Gconsensus;
  for iii = 1:size(WARPED_audio,2)
  if iii == 1
      c_agg = Gconsensus{1,iii}{1};
  else
      c_agg = cat(3,c_agg,Gconsensus{1,iii}{1});
   end
  end

    else
DataU.WARPED_TIME = WARPED_TIME;
DataU.WARPED_audio = WARPED_audio;
DataU.Gconsensus = Gconsensus; 
  for iii = 1:size(WARPED_audio,2)
      c_agg = cat(3,c_agg,Gconsensus{1,iii}{1});
  end



    end
    
end


% TO DO: aggregate all concensus images 

% Get timing and spectral data


   
  
[DataD.sim_score, DataD.vector_score, DataD.A_diff,DataD.S_diff] = FS_PreMotor_FeaturePlot(WARPED_TIME,WARPED_audio,Gconsensus,c_agg);

% Get timing and spectral data
[DataU.sim_score, DataU.vector_score, DataU.A_diff,DataU.S_diff] = FS_PreMotor_FeaturePlot(WARPED_TIME,WARPED_audio,Gconsensus,c_agg);



 

end



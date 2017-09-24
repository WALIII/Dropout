%DirUndir_Compare 01

% Compare activity btw the two cases


rule1 = find( Motif_ind(3,:) ==  0 & Motif_ind(1,:) ==  Motif_ind(2,:)-1 );% Undirected soedit ScrapHeng
rule2 = find( Motif_ind(3,:) ==  1 & Motif_ind(1,:) ==  Motif_ind(2,:)-1);% Directed song

[idx1, calcium1, song1] = FS_PreMotor_plot2(song,calcium,align,33,Motif_ind,rule1);

[idx2, calcium2, song2] = FS_PreMotor_plot2(song,calcium,align,33,Motif_ind,rule2);

Cal{1} = calcium1; Cal{2} = calcium2 ; 
Alp{1} = align; Alp{2} = align; 
FS_PreMotor_trace_comp(Cal, Alp)

figure(); 
ax1 = subplot(211);
imagesc(song1);
ax2 = subplot(212);
imagesc(song2);
title('Undirected');
linkaxes([ax1, ax2], 'x');
a2 = align/25*48000/1000;
xlim([a2-100 a2+100]);


% % streatch Wavs
% counter = 1;
% for i = rule1
% WAVcell{1}{counter} = song_r(i,align/25*48000-8000:align/25*48000+size(TEMPLATE,1)+5000)';
% counter = counter+ 1;
% end
% counter = 1;
% for i = rule2
% WAVcell{2}{counter} = song_r(i,align/25*48000-10000:align/25*48000+size(TEMPLATE,1)+10000)';
% counter = counter+1;
% end
% 
% Y = cat(1,zeros(3000,1), TEMPLATE, zeros(8000,1)); % add zeros to pad
% [WARPED_TIME, WARPED_audio, Index] = FS_PreMotor_Warp(WAVcell,Y);
% 
% 
% % Consensus
% % Spectral Density Image
% counter = 1;
% for iii = 1:size(WARPED_audio,2)
% %[Gconsensus{iii},F,T] = CY_Get_Consensus(WARPED_audio{iii});
% 
% for ii = 1: size(WARPED_audio{iii},2)
% %[IMAGE{iii}(:,:,ii), T2,F2]= FS_Spectrogram(WARPED_audio{iii}(:,ii),48000);
% audioVect(:,counter) = downsample(zftftb_rms(WARPED_audio{iii}(:,ii)',48000),100);
% audioVectT(:,counter) = WARPED_audio{iii}(:,ii)';
% counter = counter+1;
% end
% end
% figure(); imagesc(audioVect);
% 
% 
% 
% % Get Average consensus images, and plot them!
% im1 = mean(Gconsensus{1}{1},3);
% im2 = mean(Gconsensus{2}{1},3);
% im3 = mean(IMAGE{1},3);
% im4 = mean(IMAGE{2},3);
% 
% figure();
% XMASS_song(im2(:,:),im1(:,:),im2(:,:),F,T,[0.0001 0.1] );
% figure();
% XMASS_song(im3(:,:),im4(:,:),im3(:,:),F2,T2, [0.0001 0.6]);
% 
% 
% 
% 
% % Sim Score
% %[sim_score, vector_score, A_diff,S_diff] = FS_PreMotor_FeaturePlot(WARPED_TIME,WARPED_audio,Gconsensus,c_agg)

function D2 = WarpRegress(D);
%load('Combined_data.mat')
warning off

template = D.song_r(65,:)'; % add zeros to pad
fs = 48000;


counter = 1;
disp(' Time warping data')
for i = 1:size(D.song_r,1)

    try
        
        [song_start, song_end, score_d(counter,:)] = find_audio(D.song_r(i,:)', template, fs, 'match_single', true,'constrain_length', 0.4);
        [WARPED_TIME(:,:,counter) WARPED_audio(:,counter)]  = warp_audio(D.song_r(i,song_start*fs:song_end*fs), template, fs,[]);
        
        idex(:,counter) = i; % trial number
        disp(['Finished warping ' num2str(counter), 'of ', num2str(size(D.song_r,1))]);
        
      counter = counter+1;
    catch
        disp(['failure. on trial  ', num2str(i)]);
    end
end

disp(' Sorting data...')
        D2.song = D.song(idex,:);
        D2.song_r = D.song_r(idex,:);
        D2.song_w = WARPED_audio';
        D2.unsorted = D.unsorted(idex,:,:);
        D2.warped_time = WARPED_TIME;
        D2.index = idex;
        D2.motif_ind = D.Motif_ind(:,idex);
        

        % smooth data:
        C = downsample(smoothdata(D2.song_w.^2,2,'gaussian',1000)',1000)';
        % find outliers:
        TF = isoutlier(C(:,10:40),1);
        I = find(mean(TF')<0.3);
        
        D2.song = D2.song(I,:);
        D2.song_r = D2.song_r(I,:);
        D2.song_w = D2.song_w(I,:);
        D2.song_wds = C(I,:);
        D2.unsorted = D2.unsorted(I,:,:);
        
        D2.warped_time = D2.warped_time(:,:,I);
        
        
disp(' Getting Gcon')
%[Gconsensus3,f,t] = CY_Get_Consensus(D2.song_w,fs);
%D2.Gcon = Gconsensus3;
%figure(); imagesc(mean(Gconsensus3{1},3));
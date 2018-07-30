function D2 = WarpRegress(D);
%load('Combined_data.mat')


template = D.song_r(1,:)'; % add zeros to pad
fs = 48000;


counter = 1;
disp(' Time warping data')
for i = 1:100%size(D.song_r,1)

    try
        [song_start, song_end, score_d(counter,:)] = find_audio(D.song_r(i,:)', template, fs, 'match_single', true,'constrain_length', 0.25);
        [WARPED_TIME{counter} WARPED_audio(:,counter)]  = warp_audio(D.song_r(i,song_start*fs:song_end*fs), template, fs,[]);
        
       D2.song_dsw(counter,:) = downsample(zftftb_rms(WARPED_audio(0.25*fs:end,counter),48000),1000);

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

disp(' Getting Gcon')
%[Gconsensus3,f,t] = CY_Get_Consensus(WARPED_audio,fs);
%D2.Gcon = Gconsensus3;
%figure(); imagesc(mean(Gconsensus3{1},3));
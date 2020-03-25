function [allVids,start_frame,start_time,aligned] =  DU_Align_Combined(out,song_start,song_end,results);

% [song_start, song_end, score_d] = find_audio(out.audio_data, TEMPLATE, 48000, 'match_single', false);


fs = 48000;

for ii = 1:size(song_start,2)
    
    idx1=song_start(ii); %time in seconds
    
    [~,loc1]= min(abs(out.mov_time-idx1));
    
    %remainder{counter} = roi_ave.interp_time{i}(loc1)-idx1; % this is the offset
    
    
    % get offset
    
    
    
    start_frame(ii) = loc1; % align to this frame
    % save these for time warping later...
    start_time(ii) = song_start(ii);
    end_time(ii) = song_end(ii);
    
    warning off;
    g = zftftb_rms(out.audio_data(round(idx1*fs):round((idx1*fs)+((idx1+1.5*fs)))),48000);
    
    song_rms{ii} = g';
    song{ii} = out.audio_data(round(idx1*fs):round((idx1*fs)+((idx1+1.5*fs))));
end

disp('done');

% concat:
sz = size(song_rms{1},2)-200;
for i = 1:size(song_rms,2)
    stplt(i,:) = song_rms{i}(1:sz);
end

% remove outliers:
TF = isoutlier(stplt(:,1000:30000),1);
I = find(mean(TF')<0.1);

stplt =  stplt(I,:);
figure(); imagesc(stplt); colormap(bone); title('aligned songs');

 start_frame = start_frame(I);
 
 % cycle through movies:
 
 figure(); 
 for i = 1: size(start_frame,2)
     alignedVid = out.mov_data(:,:,start_frame(i):start_frame(i)+30);
     allVids(:,:,:,i) = alignedVid;
     
      % Align results:
      aligned.C_raw(:,:,i) = results.C_raw(:,start_frame(i)-20:start_frame(i)+30);
      aligned.C(:,:,i) = results.C(:,start_frame(i)-20:start_frame(i)+30);
      aligned.S(:,:,i) = full(results.S(:,start_frame(i)-20:start_frame(i)+30));
      
 end
 
 

 

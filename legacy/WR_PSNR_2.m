function [Trial_peaksnr] = WR_PSNR_2(video_1,video_2)

% Make a histogram of the differences in peak SNR

% wired = video_1
% wireless = video_2

counter = 1;

for ii = 1:550; 
    ref = video_1.frames(:,:,:,ii);
    A = imhistmatch(video_2.frames(:,:,:,ii),ref);
    X(counter) =  psnr(ref,A); 
    counter = counter+1;
end;


Trial_peaksnr = X;


        
        
        
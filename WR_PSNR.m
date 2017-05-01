function [peaksnr, variance, pixelval] = WR_PSNR(DIR)

% Make a histogram of the differences in peak SNR

% run in mat directory


mov_listing=dir(fullfile(DIR,'*.mat'));
mov_listing={mov_listing(:).name};
counter = 1;


filenames=mov_listing;


[nblanks formatstring]=fb_progressbar(100);
fprintf(1,['Progress:  ' blanks(nblanks)]);

for i=1:length(mov_listing)
    
    
      [path,file,ext]=fileparts(filenames{i});


	fprintf(1,formatstring,round((i/length(mov_listing))*100));
    FILE = fullfile(DIR,mov_listing{i})
    	load(FILE,'video');

G = mean(video.frames,4);

for ii = 1:550; 
    Y(counter) = psnr(uint8(G),video.frames(:,:,:,ii)); 

    Z(counter) = mean(var(double(squeeze(video.frames(:,:,2,ii))))) - mean(var(double(squeeze(G(:,:,2)))));% mean variance
    counter = counter+1;
    
    pixelval_p(:,:,ii) = double(video.frames(:,:,2,ii))-double((G(:,:,2)));
    
end;

pixelval{i} = double(pixelval_p(:));


end
variance = Z;
peaksnr = Y;


        
        
        
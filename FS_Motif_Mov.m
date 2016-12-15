function [ConcVid Ticks] = FS_Motif_Mov(C);
% run in directory with mat files.

fs = 48000; %audio frame rate
vfs = 30; %video frame rate
ConcVid = [];
Ticks = [];
counter = 1;
% Step one- concat all the videos at the proper place. Save these cuts
for i = 1: length(C);
    
    % index into the videos
    load(C{2,i},'video')

    idx1=C{1,i}/48000; %time in seconds
   clear CUTS;
    for iii = 1:size(idx1,2)
    [~, CUTS_t] = min(abs(video.times-idx1(iii))); %what is the closest time in frames, using time index
    CUTS(iii)= CUTS_t;
    end
    
 
         

    
    for ii = 2:size(CUTS,2)
        
        if ii==2;
            temp(:,:,:,:) = video.frames(:,:,:,CUTS(ii-1):CUTS(ii));
        else  
          temp2(:,:,:,:) = video.frames(:,:,:,CUTS(ii-1):CUTS(ii));
          temp3(:,:,:,:) = cat(4,temp,temp2);
          temp = temp3;
          clear temp2;
          clear temp3;
        end
        
        % Keep track of where in the matrix the breaks are...
        if counter == 1;
             Ticks(counter) = 1+CUTS(ii)-CUTS(ii-1);
             counter = counter+1;
        else 
             Ticks(counter) = Ticks(counter-1)+1+(CUTS(ii)-CUTS(ii-1));
             counter = counter+1;
        end
        
    end
    
    if isempty(ConcVid)
    ConcVid = temp;
    clear temp;
    else
        ConcVid = cat(4,ConcVid,temp);
        clear temp;
    end;
    
end
    


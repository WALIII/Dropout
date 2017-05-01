function   [MaxProj, G2] = FS_align()

% Motion correction for Calcium imaging videos based on the minimum
% projection.

% run in .mat directory.

mov_listing=dir(fullfile(pwd,'*.mat')); % Get all .mat file names
    mov_listing={mov_listing(:).name};
    filenames=mov_listing;

    

 %for i=1:length(mov_listing) % for all .mat files in directory,







disp('Performing Motion Correction transform calculation across all trials');
% X5 = X3(:,:,1); % Take the first days's aligned, mean projeciton....
%

%tform = imregtform(X3(:,:,i),X3(:,:,1),'rigid',optimizer,metric); %create transform for Max projection comparison across days
  %%--- Loop through each movie and perform intensity based image correction, based on aligning the average max projection.
  for  iii = 1:length(mov_listing)
      
      if iii == 1;
        [path,file,ext]=fileparts(filenames{1});
            load(fullfile(pwd,mov_listing{1}),'mov_data');
        for i = 1:size(mov_data,4) % Load in data
          mov_data2(:,:,i) = double(squeeze(mov_data(:,:,2,i))); % convert to
        end
        MaxProj(:,:,1) = min(mov_data2,[],3); % Take MAx projection of the video
        disp('Performing Motion Correction transform calculation for the first trial');
      else

      
        clear mov_data_aligned; clear mov_data2; clear mov_data; clear mov_data_actual; clear mov_data3; % Clear out remining buffer...
       [path,file,ext]=fileparts(filenames{iii});
           load(fullfile(pwd,mov_listing{iii}),'mov_data');

           for iiv = 1:size(mov_data,4) % Load in data
             mov_data2(:,:,iiv) = double(squeeze(mov_data(:,:,2,iiv))); % convert to
           end

%            for ii = 1:size(mov_data,4)
%            [temp Greg] = dftregistration(fft2(MaxProj(:,:,1)),fft2(mov_data2(:,:,ii)),100);
%            
%            mov_data_aligned_actual(:,:,i) = abs(ifft2(Greg)); %% keep this data propogating through function....
%            end

           % align to the min projection for each one.
%            Local_proj = min(mov_data2,[],3);
%            [temp Greg] = dftregistration(fft2(MaxProj(:,:,1)),fft2(Local_proj),100);
%            for ii = 1:size(mov_data,4)
%            mov_data_aligned_actual(:,:,ii) = abs(ifft2(Greg)); %% keep this data propogating through function....
%            end

%           mov_data_aligned =  []; % clear out the variable....
%             save(fullfile(path,[file '.mat']),'mov_data_aligned','-append');
         % G{iii} =  std(mov_data_aligned_actual,[],3);
          G2{iii} = mean(mov_data2,3);
%             save(fullfile(path,[file '.mat']),'mov_data_aligned','-append'); % store data here temporarily...

        %    FS_Write_IM(file,mov_data_aligned)
         clear mov_data_aligned_actual;   clear mov_data_aligned;
         disp('Next movie...');
      end
  end

 

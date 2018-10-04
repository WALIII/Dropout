function D2 = WarpRegress(D,varargin);
%load('Combined_data.mat')
warning off


nparams=length(varargin);

if mod(nparams,2)>0
	error('Parameters must be specified as parameter/value pairs');
end


template = D.song_r(1,:)'; % add zeros to pad

for i=1:2:nparams
	switch lower(varargin{i})
		case 'template'
			template=varargin{i+1};
		case 'sono_colormap'
			sono_colormap=varargin{i+1};
    end
end

            
            
fs = 48000;


counter = 1;
disp(' Time warping data')

% Pre alocate warped audio
for i = 1:10%size(D.song_r,1)

    try
        
        [song_start, song_end, score_d(counter,:)] = find_audio(D.song_r(i,:)', template, fs, 'match_single', true,'constrain_length', 0.4);
        [WARPED_TIME(:,:,counter) WARPED_audio(:,counter)]  = warp_audio(D.song_r(i,song_start*fs:song_end*fs), template, fs,[]);
        UNWARPED{counter} = D.song_r(i,song_start*fs:song_end*fs);
        idex(:,counter) = i; % trial number
        disp(['Finished warping ' num2str(counter), 'of ', num2str(size(D.song_r,1))]);
        
      counter = counter+1;
    catch
        disp(['failure. on trial  ', num2str(i)]);
    end
end

% Put the unwarped songs in a single matrix...
 C=UNWARPED; 
    maxLengthCell=max(cellfun('size',C,2));  %finding the longest vector in the cell array
    for i=1:length(C)
        for j=cellfun('size',C(i),2)+1:maxLengthCell
             C{i}(j)=0;   %zeropad the elements in each cell array with a length shorter than the maxlength
        end
    end
    UNWARPED_audio=repmat(cell2mat( [ C(:) ] ),size(C,1));
    clear C
    


disp(' Sorting data...')
        D2.song = D.song(idex,:);
        D2.song_r = D.song_r(idex,:);
        D2.song_w = WARPED_audio';
        D2.song_uw = UNWARPED_audio;
        D2.unsorted = D.unsorted(idex,:,:);
        D2.warped_time = WARPED_TIME;
        D2.index = idex;
        try % legacy
        D2.motif_ind = D.Motif_ind(:,idex);
        catch
        D2.motif_ind = D.motif_ind(:,idex);
        end

        % smooth data:
        temp1 = zftftb_rms(D2.song_w',48000);
        temp2 = downsample(temp1,100);
        C = temp2';
        temp3 = zftftb_rms(D2.song_uw',48000);
        temp4 = downsample(temp3,100);
        C2 = temp4';
        C2(C2<-40) = mean(min(C2));    
        C(C<-40) = mean(min(C));
        clear temp1 temp2 temp3 temp4
        % find outliers:
        TF = isoutlier(C(:,10:250),1);
        I = find(mean(TF')<0.3);


        
        D2.song = D2.song(I,:);
        D2.song_r = D2.song_r(I,:);
        D2.song_w = D2.song_w(I,:);
        D2.song_uw = D2.song_uw(I,:);
        D2.song_uwds = C2(I,:);
        D2.song_wds = C(I,:);
        D2.unsorted = D2.unsorted(I,:,:);
        
        D2.warped_time = D2.warped_time(:,:,I);
        
        
disp(' Getting Gcon')
%[Gconsensus3,f,t] = CY_Get_Consensus(D2.song_w,fs);
%D2.Gcon = Gconsensus3;
%figure(); imagesc(mean(Gconsensus3{1},3));


function [Gconsensus3,CalciumDat,WARPED_TIME,WARPED_audio,idex,f,t] =  Inscopix_regression(ROI_data_cleansed);

% Warp audio, and get contours for LW76 to run regression analyis
% on ROIs

% d062018

try

%% INSCOPIX
disp('processing inscopix data');
% params
fs = 22000;

data = ROI_data_cleansed;
% Concat all calcium data
disp(' Getting calcium data')
for day = 1:5;
for trials = 1:size(data{1,day}.align_detrended,2);
for cells = 1:81;
data2{day}.all(trials,:,cells) = (data{1,day}.align_detrended{trials}(:,cells));
end
end
end

% Concat all  song data
disp(' Getting song data')
counter = 1;
for i = 1:5;
for ii = 1:size(data{i}.mic_data,2)
mic_data(counter,:) = data{i}.mic_data{ii};
indexA(:,counter) = i; %day
counter = counter+1;
end
end

% Template data
template = data{5}.mic_data{1}'; % add zeros to pad


catch
 %% FREEDOMSCOPE DATA
  %params
  fs = 48000;



disp('processing FreedomScope data');
disp('clipping the pad by a bit at te end...')
    % Concat all calcium data
disp(' Getting calcium data')
for day = 1:size(ROI_data_cleansed,2);
for trials = 1:size(ROI_data_cleansed{day}.analogIO_dat,2);
for cells = 1:size(ROI_data_cleansed{day}.interp_raw,1);
data2{day}.all(trials,:,cells) = ROI_data_cleansed{day}.interp_dff(cells,trials);
end
mic_data(trials,:) = ROI_data_cleansed{day}.analogIO_dat{trials}(1:end-(0.75*fs));
end
end



template = mic_data(1,:)'; % add zeros to pad

end


CalciumDat_temp = cat(1,data2{1}.all,data2{2}.all,data2{3}.all,data2{4}.all,data2{5}.all);


counter = 1;
disp(' Time warping data')
for i = 1:size(mic_data,1)

    try
        [song_start, song_end, score_d(counter,:)] = find_audio(mic_data(i,:)', template, fs, 'match_single', true,'constrain_length', 0.25);
        [WARPED_TIME{counter} WARPED_audio(:,counter)]  = warp_audio(mic_data(i,song_start*fs:song_end*fs), template, fs,[]);
        idex(1,counter) = indexA(:,i);
        idex(2,counter) = i; % trial number
            CalciumDat(counter,:,:) = CalciumDat_temp(i,:,:);
            counter = counter+1;
            disp(['Finished warping' num2str(counter)]);
    catch
        disp(['failure. on trial  ', numtstr(i)]);
    end
end

disp(' Getting Gcon')
[Gconsensus3,f,t] = CY_Get_Consensus(WARPED_audio,fs);


%
figure(); imagesc(mean(Gconsensus3{1},3));
%
% A = mean(Gconsensus1{1},3);
% B = mean(Gconsensus2{1},3);
% C = mean(Gconsensus3{1},3);
%
% figure();
% XMASS_song(A,B,C);


% concat w/ data

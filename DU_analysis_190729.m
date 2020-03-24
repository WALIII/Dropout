
function  [Out_struct] = DU_analysis_190729
% Gather direct and Indirect data in batches for statistics



% Go thorugh all files and gather data...

mov_listing=dir(fullfile(pwd,'*.mat'));
mov_listing={mov_listing(:).name};
filenames=mov_listing;


for ii=1:length(mov_listing)
    % cut it out of the datastructure

    [path,file,ext]=fileparts(filenames{ii});
    FILE = fullfile(pwd,mov_listing{ii});
    % Load data from each folder
    load(FILE,'calcium','align','Motif_ind');

    %song_lengths, for
    if strcmp(file,'LR33_01_06')
        S1 = 5; S2 = 17;
    elseif strcmp(file,'LYY_10_07')
        S1 = 3; S2 = 30;
    elseif strcmp(file,'lr28_02_10')
        S1 = 5; S2 = 27;
    elseif strcmp(file, 'lr5rblk60_12_05')
        S1 = 1; S2 = 25;
    elseif strcmp(file, 'lny39_02_03_ring')
        S1 = 3; S2 = 14;
    elseif strcmp(file, 'lr77_01_24')
        S1 = 2; S2 = 30;
    else
        S1 = 5; S2 = 25;
    end

    [data_temp] = FS_Data(calcium,align,Motif_ind,S1,S2);
    Out_struct{ii}.BirdNo = file;
    Out_struct{ii}.BirdData = data_temp;

    [stats, amp_data{ii}] = DU_Prominence(data_temp);
    [stats var_data{ii}] =  DU_Variability(data_temp);
    % Take a consistant pad for trial:trial covariance
    [data_temp] = FS_Data(calcium,align,Motif_ind,5,25);
    [eig1,eig2,sorting,corr_data{ii}]= FS_cellclust_comp(data_temp);
    if ii == 1
        Songs_undirected = size(data_temp.undirected,1);
        Songs_directed = size(data_temp.directed,1);
    else
        Songs_undirected = Songs_undirected +  size(data_temp.undirected,1);
        Songs_directed = Songs_directed +  size(data_temp.directed,1);
    end

end


% PLotting
figure();
for i = 1:6;
    hold on;
    scatter(amp_data{i}.MeanROI(2,:),amp_data{i}.MeanROI(1,:));
end
x = [0 9];
y = [0 9];
title(' Amplitude, all cells');
line(x,y,'Color','red','LineStyle','--')

% PLotting
figure();
for i = 1:6;
    hold on;
    scatter(var_data{i}.MeanPearsonScores(1,:),var_data{i}.MeanPearsonScores(2,:));
end
x = [0 1];
y = [0 1];
title(' Variance, all cells');
line(x,y,'Color','red','LineStyle','--')

figure();
for i = 1:6;
    hold on;
    scatter(corr_data{i}.mCVC_D,corr_data{i}.mCVC_U);
end
x = [0 1];
y = [0 1];
title(' co-deviance, all cells');
line(x,y,'Color','red','LineStyle','--')


for i = 1:6
    if i ==1;
        % amp data
        M1 = amp_data{i}.MeanROI(1,:);
        M2 = amp_data{i}.MeanROI(2,:);
        Msig = amp_data{i}.Msig;
        % var data
        MPS = var_data{i}.MeanPearsonScores;
        Vsig = var_data{i}.Stat_Difference;
        PSU = var_data{i}.PearsonScores_U;
        PSD = var_data{i}.PearsonScores_D;
        % corr data
        CU = corr_data{i}.CVC_U(:);
        CD = corr_data{i}.CVC_D(:);
        mCD = corr_data{i}.mCVC_U;
        mCU = corr_data{i}.mCVC_U;

    else
        M1t = amp_data{i}.MeanROI(1,:);
        M2t = amp_data{i}.MeanROI(2,:);
        Msigt = amp_data{i}.Msig;
        % var
        MPSt = var_data{i}.MeanPearsonScores;
        Vsigt = var_data{i}.Stat_Difference;
        PSUt = var_data{i}.PearsonScores_U;
        PSDt = var_data{i}.PearsonScores_D;
        % corr data
        CUt = corr_data{i}.CVC_U(:);
        CDt = corr_data{i}.CVC_D(:);
        mCDt = corr_data{i}.mCVC_D;
        mCUt = corr_data{i}.mCVC_U;

        % concat all data...
        M1 = cat(2,M1,M1t);
        M2 = cat(2,M2,M2t);
        MPS = cat(2,MPS,MPSt);
        Msig = cat(1,Msig,Msigt);
        Vsig = cat(2,Vsig,Vsigt);
        PSD = cat(1,PSD,PSDt);
        PSU = cat(1,PSU,PSUt);

        CU = cat(1,CU, CUt);
        CD = cat(1,CD, CUt);
        mCD = cat(2,mCD, mCDt);
        mCU = cat(2,mCU, mCUt);
        clear M1t M2t
    end
end

% Print out stats
Significane_Amplitude = ranksum(M1,M2,'tail','right')
Significane_VarMean = ranksum(MPS(2,:),MPS(1,:),'tail','right')
Significane_CorrMean = ranksum(mCU,mCD,'tail','right')
AllSigUnits_Var = sum(Vsig)./size(Vsig,1)*100
AllSigUnits_Mean = sum(Msig)./size(Vsig,2)*100

[p, observeddifference, effectsize] = permutationTest(mCU,mCD, 100000)

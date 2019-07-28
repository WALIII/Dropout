
function  DU_analysis_190729
% Gather direct and Indirect data in batches for statistics



% Go thorugh all files and gather data...

mov_listing=dir(fullfile(pwd,'*.mat'));
mov_listing={mov_listing(:).name};
filenames=mov_listing;

    figure();
    title('difference in amp')
    
    
for ii=1:length(mov_listing)
      % cut it out of the datastructure
      
    [path,file,ext]=fileparts(filenames{ii});
    FILE = fullfile(pwd,mov_listing{ii});

% make a folder, put these inside...

load(FILE,'calcium','align','Motif_ind');

[data_temp] = FS_Data(calcium,align,Motif_ind,5,25);


[stats, amp_data{ii}] = DU_Prominence(data_temp);
[stats var_data{ii}] =  DU_Variability(data_temp)

if ii == 1
Songs_undirected = size(data_temp.undirected,1);
Songs_directed = size(data_temp.directed,1);
else
   Songs_undirected = Songs_undirected +  size(data_temp.undirected,1);
   Songs_directed = Songs_directed +  size(data_temp.directed,1);
end

end

figure();
for i = 1:6;
hold on;
    scatter(amp_data{i}.MeanROI(2,:),amp_data{i}.MeanROI(1,:));
end
   x = [0 9];
y = [0 9];
line(x,y,'Color','red','LineStyle','--')

% collect all data
for i = 1:6
    if i ==1;
        M1 = amp_data{i}.MeanROI(1,:);
        M2 = amp_data{i}.MeanROI(2,:);
        MPS = var_data{i}.MeanPearsonScores;
        Vsig = var_data{i}.Stat_Difference;  
        PSU = var_data{i}.PearsonScores_U;
        PSC = var_data{i}.PearsonScores_D;
    else
        M1t = amp_data{i}.MeanROI(1,:);
        M2t = amp_data{i}.MeanROI(2,:);
        MPSt = var_data{i}.MeanPearsonScores
        Vsigt = var_data{i}.Stat_Difference; 
        
        M1 = cat(2,M1,M1t);
        M2 = cat(2,M2,M2t);
        MPS = cat(2,MPS,MPSt);
        Vsig = cat(2,Vsig,Vsigt);
        clear M1t M2t
    end
end
    
Significane_Amplitude = ranksum(M1,M2)
Significane_VarMean = ranksum(MPS(2,:),MPS(1,:))

AllSigUnits = sum(Vsig)/size(Vsig,2)*100
[aa bb] = ttest(M1,M2);


figure();
hold on;
for i = 1:200
 plot(1:2,[MPS(1,i)-MPS(1,i) MPS(2,i)-MPS(1,i)])
end


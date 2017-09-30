
function [D_TDif D_HDif U_HDif U_TDif]= scrap9(data,data_peaks)
counter = 1;
D_HDif = 0;
D_TDif = 0;

for cell = 1:size(data_peaks.DirMeanPk,2)
for i = 1:1:size(data_peaks.DirPeaks{1},2) % for each cell
    cell;
   A =  data_peaks.DirMeanPk{cell}; % mean height, compare to this
   
   B = data_peaks.DirMeanLoc{cell}; % mean location, extract from trials
   [M I] = max(A);% largest Peak
   LL1 = B(I);% location of largest peak
    
    data_peaks.DirLocs{cell};
   Ymean =  data_peaks.DirMean(:,cell);
    G = data.directed(i,:,cell);
    y = G;%+abs(min(Ymean));
    [M2 I2] = max(data_peaks.DirPeaks{cell}{i}); % largest Peak in data
    LL2 = data_peaks.DirLocs{cell}{i}(I2); %index into location of peak
   
try
    N = A-y(B);% difference in peak at mean peak location
catch
    disp('?')
end

    N2 = LL1-LL2-2;% difference in max peak location 

    D_HDif = horzcat(D_HDif,N);
    D_TDif = horzcat(D_TDif,N2);
    
end
end;
clear NT;
clear NT2;
clear N;
U_HDif = 0;
U_TDif = 0;

%undirected
for cell = 1:size(data_peaks.UnDirMeanPk,2) % for each cell
for i = 1:size(data_peaks.UnDirPeaks{1},2) % for each cell
    
   A =  data_peaks.UnDirMeanPk{cell}; % mean height, compare to this
   
   B = data_peaks.UnDirMeanLoc{cell}; % mean location, extract from trials
   [M I] = max(A);% largest Peak
   LL1 = B(I);% location of largest peak
    
    data_peaks.UnDirLocs{cell};
   Ymean =  data_peaks.UnDirMean(:,cell);
    G = data.undirected(i,:,cell);
    y = G;%+abs(min(Ymean));
    [M2 I2] = max(data_peaks.UnDirPeaks{cell}{i}); % largest Peak in data
    LL2 = data_peaks.UnDirLocs{cell}{i}(I2); %index into location of peak
   
    
    N_2 = A-y(B);% difference in peak at mean peak location
    N2_2 = LL1-LL2-2;% difference in max peak location 

    U_HDif = horzcat(U_HDif,N_2);
    U_TDif = horzcat(U_TDif,N2_2);
    
end
end;

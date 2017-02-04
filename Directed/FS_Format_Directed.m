function [data] = FS_Format_Directed(Directed, Undirected)
% format and smooth data to work with pre-existing functions


% FORMAT: data.undirected(trial,time,cell)


% Format Directed Data data.directed(trial,time,cell)
for trial = 1:size(Directed.interp_dff,2); 
    for cell = 1:size(Directed.interp_dff,1);
        %temp =  Directed.interp_dff{cell,trial}; 
        temp =  tsmovavg(Directed.interp_dff{cell,trial},'s',3); 
        data.directed(trial,:,cell) = zscore(temp(:,3:end));
        clear temp;
    end;
end;

% Format Undirected Data (data.undirected)

for trial = 1:size(Undirected.interp_dff,2); 
    for cell = 1:size(Undirected.interp_dff,1);  
        %temp = Undirected.interp_dff{cell,trial};
        temp =  tsmovavg(Undirected.interp_dff{cell,trial},'s',3); 
        data.undirected(trial,:,cell) = zscore(temp(:,3:end));
        clear temp;
    end;
end;

G =  mean(data.directed(:,:,:),1);
G1 = squeeze(G);
[~, index] = sort(max(G1, [], 1), 'descend');
data.directed = data.directed(:,:,index);
data.undirected = data.undirected(:,:,index);

% [~, srt] = sort(max(neuron.C, [], 2), 'descend');


% 
% data.directed(:,:,[2, 3,4,9,12,13,34,42, 35]) = [];
% data.undirected(:,:,[2, 3,4,9,12,13,34,42, 35]) = [];

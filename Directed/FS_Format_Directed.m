function [data] = FS_Format_Directed(Directed, Undirected,motif)
% format and smooth data to work with pre-existing functions


% FORMAT: data.undirected(trial,time,cell)


% Format Directed Data data.directed(trial,time,cell)
counter = 1;
for trial = 1:size(Directed.interp_dff,2); 
     if Directed.motif{trial} == motif;
    for cell = 1:size(Directed.interp_dff,1);
        %temp =  Directed.interp_dff{cell,trial}; 
        temp =  tsmovavg(Directed.interp_raw{cell,trial},'s',4);
        temp = temp(:,4:end-1);
        temp = temp-mean(temp);
        data.directed(counter,:,cell) = (temp);
        clear temp;
    end;
    counter = counter+1;
end;
end;

% Format Undirected Data (data.undirected)
counter = 1;
for trial = 1:size(Undirected.interp_dff,2); 
    
     if Undirected.motif{trial} == motif;
    for cell = 1:size(Undirected.interp_dff,1);  
        %temp = Undirected.interp_dff{cell,trial};
        temp =  tsmovavg(Undirected.interp_raw{cell,trial},'s',4); 
        temp = temp(:,4:end-1);
        temp = temp-mean(temp);
        data.undirected(counter,:,cell) = (temp);
        clear temp;
    end;
        counter = counter+1;
end
end;

%sort by max quality...
G =  mean(data.directed(:,:,:),1);
G1 = squeeze(G);
[~, index] = sort(max(G1, [], 1), 'descend');
data.directed = data.directed(:,1:end-10,index);
data.undirected = data.undirected(:,1:end-10,index);

% [~, srt] = sort(max(neuron.C, [], 2), 'descend');


% 
% data.directed(:,:,[2, 3,4,9,12,13,34,42, 35]) = [];
% data.undirected(:,:,[2, 3,4,9,12,13,34,42, 35]) = [];

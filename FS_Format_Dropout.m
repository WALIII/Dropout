function [data] = FS_Format_Dropout(roi_ave, directed,undirected, motif)
% WALIII

% format and smooth data to work with pre-existing functions

%PARAMS
startT = 4; %12;
finalT = 4; %28;%
smooth =2;%4


% FORMAT: data.undirected(trial,time,cell)


% Index into the right trials
G2 = 0;
undirected2 = regexprep(undirected, '.mov', '');
directed2 = regexprep(directed, '.mov', '');

FN = regexprep(roi_ave.filename, '.mat', '');
for i = 1:size(undirected2,2)
startIndex = regexp(FN,undirected2{i});
G = find(~cellfun(@isempty,startIndex));
G2 = horzcat(G2,G);
end
UnDirectedTrials = G2(2:end);

G2 = 0;
clear G; clear startIndex;
for i = 1:size(directed2,2)
startIndex = regexp(FN,directed2{i});
G = find(~cellfun(@isempty,startIndex));
G2 = horzcat(G2,G);
end
DirectedTrials = G2(2:end);



% Format Directed Data data.directed(trial,time,cell)
counter = 1;
for trial = DirectedTrials %
  %if roi_ave.motif{trial} == motif;
    for cell = 1:size(roi_ave.interp_dff,1);
        %temp =  Directed.interp_dff{cell,trial};
        temp =  tsmovavg(roi_ave.interp_dff{cell,trial},'s',smooth);
        data.directed(counter,:,cell) = zscore(temp(:,startT:end-finalT));
        clear temp;
    end;
    counter = counter+1;
  %end;

end;


% Format Undirected Data (data.undirected)
counter = 1;
for trial = UnDirectedTrials;
   %if roi_ave.motif{trial} == motif;
    for cell = 1:size(roi_ave.interp_dff,1);
        %temp = Undirected.interp_dff{cell,trial};
        temp =  tsmovavg(roi_ave.interp_dff{cell,trial},'s',smooth);
        data.undirected(counter,:,cell) = zscore(temp(:,startT:end-finalT));
        clear temp;
    end;
    counter = counter+1;
   %end

end;

% sort by max quality...
% G =  mean(data.directed(:,:,:),1);
% G1 = squeeze(G);
% [~, index] = sort(max(G1, [], 1), 'descend');
% data.directed = data.directed(:,:,index);
% data.undirected = data.undirected(:,:,index);

% [~, srt] = sort(max(neuron.C, [], 2), 'descend');

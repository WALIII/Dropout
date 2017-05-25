function [data] = FS_Format_Dropout(roi_ave, directed,undirected, motif)
% WALIII

% format and smooth data to work with pre-existing functions

%PARAMS
startT = 12; %12;
finalT = 28; %28;%
smooth =5;%4


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
    
 % if roi_ave.motif{trial} == motif;
          Dir_time = roi_ave.filename{trial}(12:19);
    formatIn = 'HH MM SS';
    data.dir_time(:,counter) = datenum(Dir_time,formatIn);
    
    for cell = 1:size(roi_ave.interp_raw,1);
        %temp =  Directed.interp_dff{cell,trial};
        temp =  tsmovavg(roi_ave.interp_raw{cell,trial},'s',smooth);
        % temp2 = temp(:,smooth:end)-mean(temp(:,smooth:end));
        data.directed(counter,:,cell) = (temp(:,startT:end-finalT))-min(temp(:,startT:end-finalT));
        clear temp;
    end;
    counter = counter+1;
 %end;

end;


% Format Undirected Data (data.undirected)
counter = 1;
for trial = UnDirectedTrials;

    
  %if roi_ave.motif{trial} == motif;
    Dir_time = roi_ave.filename{trial}(12:19);
    formatIn = 'HH MM SS';
    data.undir_time(:,counter) = datenum(Dir_time,formatIn);
    
    for cell = 1:size(roi_ave.interp_raw,1);
        %temp = Undirected.interp_dff{cell,trial};
        temp =  tsmovavg(roi_ave.interp_raw{cell,trial},'s',smooth);
        %temp2 = temp(:,smooth:end)-mean(temp(:,smooth:end));
        data.undirected(counter,:,cell) = (temp(:,startT:end-finalT))-min(temp(:,startT:end-finalT));
        clear temp;
    end;
    counter = counter+1;
   %end

end;
data.undir_time(2,:) = zeros;
data.dir_time(2,:) = ones;



% CLEAN DATA (mean subtraction)
for ii = 1:size(data.directed,1)
H = mean(squeeze(mean(data.directed(ii,:,:),1)),2)';
for i = 1:size(data.directed,3)
    hold on; 
    directed_2(ii,:,i) = (data.directed(ii,:,i) - H); 
    %directed_3(ii,:,i) = directed_2(ii,:,i)-mean(data.directed_2(:,:,i)',2)';
end
end

% CLEAN DATA (mean subtraction)
for ii = 1:size(data.undirected,1)
H = mean(squeeze(mean(data.undirected(ii,:,:),1)),2)';
for i = 1:size(data.undirected,3)
    hold on; 
    undirected_2(ii,:,i) = (data.undirected(ii,:,i) - H);
   % undirected_3(ii,:,i) = undirected_2(ii,:,i)-mean(data.undirected_2(:,:,i)',2)';
end
end





%--------------
% CLEAN DATA (mean subtraction)
for ii = 1:size(data.directed,1)
for i = 1:size(data.directed,3)
    hold on; 
 
    directed_3(ii,:,i) = directed_2(ii,:,i)-mean(directed_2(:,:,i)',2)';
end
end

% CLEAN DATA (mean subtraction)
for ii = 1:size(data.undirected,1)
for i = 1:size(data.undirected,3)
    hold on; 
    undirected_3(ii,:,i) = undirected_2(ii,:,i)-mean(undirected_2(:,:,i)',2)';
end
end


%------------



data.directed = directed_2;
data.undirected = undirected_2;
data.directed2 = directed_3;
data.undirected2 = undirected_3;

plot(data.directed(:,:,1)','r');

% sort by max quality...
G =  mean(data.directed(:,:,:),1);
G1 = squeeze(G);
[~, index] = sort(max(G1, [], 1), 'descend');
data.directed = data.directed(:,:,index);
data.undirected = data.undirected(:,:,index);

% [~, srt] = sort(max(neuron.C, [], 2), 'descend');

function [WAV_d WAV_u] = FS_Sep_Audio(roi_ave, directed,undirected, motif)
% FS_Sep_Audio.m

% d050217
% WAL3

% Seperate and compare audio data for directed and undirected experiment



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




counter = 1;
for trial = DirectedTrials %
%    if roi_ave.motif{trial} == motif;
     WAV_d{counter} = roi_ave.analogIO_dat{trial};
    counter = counter+1;
%    end;
end;


% Format Undirected Data (data.undirected)
counter = 1;
for trial = UnDirectedTrials;
%     if roi_ave.motif{trial} == motif;
      WAV_u{counter} = roi_ave.analogIO_dat{trial};
      counter = counter+1;
%     end;

end

function [DirectedTrials, UnDirectedTrials] = Check_Directed(roi_ave, directed,undirected);


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
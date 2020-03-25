function  out = DU_Check_Directed(out, directed,undirected);


G2 = 0;
undirected2 = regexprep(undirected, '.mov', '');
directed2 = regexprep(directed, '.mov', '');

FN = regexprep(out.filename, '.mat', '');
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

out.index.directed = zeros(1,size(out.index.movie_idx,2));
out.index.directed(G2(2:end)) = 1;
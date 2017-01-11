function [SortedCell] = FS_TickCuts(CaSignal,Ticks)

for ii = 1:size(CaSignal,1);
    clear G;
    G = CaSignal(ii,:);
%GG{1} = diff((G(1:Ticks(1)))); for i = 2:size(Ticks,2); GG{i} = diff((G(Ticks(i-1):Ticks(i)))); end;

GG{1} = (zscore(G(1:Ticks(1)))); for i = 2:size(Ticks,2); GG{i} = (zscore(G(Ticks(i-1):Ticks(i)))); end;


% NO ZSCORE
%GG{1} = ((G(1:Ticks(1)))); for i = 2:size(Ticks,2); GG{i} = ((G(Ticks(i-1):Ticks(i)))); end;


% very simple example
% assumes each entry in a is a row vector
a = GG;

% figure out longest
max_length = max(cellfun(@length, a));

% extend
a_extended = cellfun(@(x) [x zeros(1, max_length - length(x))], a, 'UniformOutput', false);

% concatenate
a_matrix = cat(1, a_extended{:});
clear Tally
SortedCell{ii} = a_matrix;
end


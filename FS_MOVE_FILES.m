function FS_MOVE_FILES(directed, undirected)

% move files regardless of type
% may not generalize

% WALIII
% 04/01/17

type = '.tif'


% Index into the right trials
G2 = 0;
undirected2 = regexprep(undirected, '.mov', '');
directed2 = regexprep(directed, '.mov', '');


% Look into the current dir

mov_listing=dir(fullfile(pwd,'*.tif'));
mov_listing={mov_listing(:).name};
filenames=mov_listing;




FN = regexprep(filenames, '.tif', '');
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

% make directories
mkdir('undirected')
mkdir('directed')


for trial=DirectedTrials
    
    copyfile(filenames{trial},'directed')
    
    
end

for trial=UnDirectedTrials
    
    copyfile(filenames{trial},'undirected')
    
end

    
    

function creat_context_file
% put all direrected files in a folder in the directory. In this example, I
% sorted gifs.

% d09/26/2017
% wal3

% Manually build context_index file
mov_listing=dir(fullfile(pwd,'*.gif'));
mov_listing={mov_listing(:).name};
mov_listing=mov_listing

% find and replace in a cell
C1 = mov_listing;
old = {'.gif'};
new = {'.mov'};
C2 = strrep(mov_listing,old,new)

undirected = C2;
clear mov_listing

cd('New Folder With Items')

% Manually build context_index file
mov_listing=dir(fullfile(pwd,'*.gif'));
mov_listing={mov_listing(:).name};
mov_listing=mov_listing

% find and replace in a cell
C1 = mov_listing;
old = {'.gif'};
new = {'.mov'};
C2 = strrep(mov_listing,old,new)

directed = C2;

save('context_index','directed','undirected')

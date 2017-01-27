function [T_Ticks, T_Files, index] = FS_directed()

% Concat videos
% Start in mat directordy

DIR = pwd;
DS = 1;

%%%Directed Song
cd('directed/extraction');

disp('extracting hits...')
[D_Tally, D_C] = FS_Motif_split();

disp('clustering audio...')
[D_Tally2 D_idx] = hilbert_FS(D_Tally);

% go into .mat folder
cd('../');
disp('extracting and formatting video..')
[D_ConcVid D_Ticks] = FS_Motif_Mov(D_C,DS);
[D_files, n] = FS_Format(D_ConcVid,1); % format


%%%UnDirected Song

cd(DIR);

cd('undirected/extraction');

disp('extracting hits...')
[U_Tally, U_C] = FS_Motif_split();

disp('clustering audio...')
[U_Tally2 U_idx] = hilbert_FS(U_Tally);

% go into .mat folder
cd('../');
disp('extracting and formatting video..')
[U_ConcVid, U_Ticks] = FS_Motif_Mov(U_C,DS);
[U_files, n] = FS_Format(U_ConcVid,1); % format


% format all
T_Ticks = [D_Ticks, U_Ticks+D_Ticks(end)];
T_Files = cat(3, D_files, U_files);

index(1:length(D_Ticks)) = 0;
index(length(D_Ticks)+1:length(D_Ticks)+length(U_Ticks)) = 1;

cd(DIR)





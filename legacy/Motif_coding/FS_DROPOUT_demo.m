function [SortedCell, Ticks, Tally2, idx, CaSignal,files ] = FS_DROPOUT_demo()

%DROPOUT START HERE

DIR = pwd;

DS = 0.25;
% Run in 'extraction'
disp('extracting hits...')
[Tally, C] = FS_Motif_split();

disp('clustering audio...')
[Tally2 idx] = hilbert_FS(Tally);


% go into .mat folder
cd('../');
disp('extracting and formatting video..')
[ConcVid Ticks] = FS_Motif_Mov(C,DS);
[files, n] = FS_Format(ConcVid,1); % format

disp('smoothing video..')
files = convn(files, single(reshape([1 1 1] / 3, 1, 1, [])), 'same'); % Smooth


% disp('Extracting ROIS');
cells = 100
size = 7

 [SpatMap,CaSignal,width,height,contour,Json] = CaImSegmentation2(files,cells,size,4,1);
% [neuron] = FS_cnmfe(files);
% CaSignal = neuron.C_raw;

[SortedCell] = FS_TickCuts(CaSignal,Ticks);

cd(DIR)

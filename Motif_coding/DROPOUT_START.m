%DROPOUT START HERE

% Run in 'extraction'
[Tally, C] = FS_Motif_split();

[Tally2 idx] = hilbert_FS(Tally);

[ConcVid Ticks] = FS_Motif_Mov(C);

% go into .mat folder
cd('../');
[ConcVid Ticks] = FS_Motif_Mov(C);

[out_mov, n] = FS_Format(ConcVid,1); % format

files = convn(out_mov, single(reshape([1 1 1] / 3, 1, 1, [])), 'same'); % Smooth


disp('Extracting ROIS');
cells = 100
size = 7
AR = 2; % Autoregressive process

[SpatMap,CaSignal,width,height,contour,Json] = CaImSegmentation2(files,cells,size,AR,1);


[SortedCell] = FS_TickCuts(CaSignal,Ticks);




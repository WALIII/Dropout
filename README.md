# Dropout
For the direct vs indirect project

## TO run the general paradigm, use: DROPOUT_START in the extraction directory.

% Run in 'extraction'

```
[Tally, C] = FS_Motif_split();

[Tally2 idx] = hilbert_FS(Tally);
```


[ConcVid Ticks] = FS_Motif_Mov(C);

% go into .mat folder
cd('../');
[ConcVid Ticks] = FS_Motif_Mov(C);

[out_mov, n] = FS_Format(ConcVid,1); % format

files = convn(out_mov, single(reshape([1 1 1] / 3, 1, 1, [])), 'same'); % Smooth


disp('Extracting ROIS');
cells = 30
size = 7

[SpatMap,CaSignal,width,height,contour,Json] = CaImSegmentation2(files,cells,size,4,1);

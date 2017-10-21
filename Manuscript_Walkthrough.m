
% Directed/Undirected paper walkthrough and statistics aggregator

% d09/29/17
% WAL3


%--------=======[   Preflight   ]=======--------%

[calcium, DATA_D, song_r, song, align, Motif_ind] =  FS_PreMotor(roi_ave,TEMPLATE,directed2,undirected2);

DirUndir_Compare % Basic data vizualizations

[data] = FS_Data(calcium,align,Motif_ind,5,25); % cut it out of the datastructure



%--------=======[ Song Analysis ]=======--------%

[DataD, DataU] = DirUndir_wav(WAVd,WAVu,TEMPLATE)

DirUndir_Plot(DataD,DataU) % plotting and basic visuals

[stats] =DirUndir_song_similarity(DataD,DataU) % stats on audio, hist plotting


%--------=======[  ROI Analysis ]=======--------%


%    ** ROI Amplitude analysis **

[stats] = DU_Prominence(data)
% TO DO: Add stats

%    ** ROI Variability analysis **

[stats] = DU_variability(data)
% TO DO: Add stats

%    ** Time of day analysis **

[stats] = DU_CorrMatrix(data)

%% [stats] = DU_TimeOfDay(data)




%%===============================================%%
%                HELPER FUNCTIONS                 %
%%===============================================%%

% Plot ROIs
figure();
cell = 1;
hold on;
plot(data.directed(:,:,cell)','g'); plot(data.undirected(:,:,cell)','m');

% Batch Function for Summary Statistics

[stats] = DU_ProcessData(data) % this will run all scripts and produce stats
                               % summary statistics.

%Schnitz plots
[indX,B,C,data] = FS_PreMotor_Schnitz(calcium, align, Motif_ind);

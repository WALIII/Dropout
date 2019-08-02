
% Directed/Undirected paper walkthrough and statistics aggregator

% d09/29/17
% d07/29/19
% WAL3


%--------=======[   Preflight   ]=======--------%

[calcium, DATA_D, song_r, song, align, Motif_ind] =  FS_PreMotor(roi_ave,TEMPLATE,directed2,undirected2);

DirUndir_Compare % Basic data vizualizations

[audioVect,audioVect2] =  DirUndir_Compare02(song_r,align,TEMPLATE); % Basic data vizualizations

Scrap_finalfig(audioVect2,Motif_ind) % check audio alignments

  % cut it out of the datastructure
[data] = FS_Data(calcium,align,Motif_ind2,5,25);


%--------=======[ Song Analysis ]=======--------%

[DataD, DataU] = DirUndir_wav(WAVd,WAVu,TEMPLATE)

DirUndir_Plot(DataD,DataU) % plotting and basic visuals

[stats] =DirUndir_song_similarity(DataD,DataU) % stats on audio, hist plotting


%--------=======[  ROI Analysis ]=======--------%
 %% this is what will go in the paper...

%    ** ROI Amplitude analysis **

[stats] = DU_Prominence(data)
% TO DO: Add stats

%    ** ROI Variability analysis **

[stats] = DU_Variability(data)
% TO DO: Add stats

%    ** ROI correlation Matrix **

[stats] = DU_CorrMatrix(data)

%    ** Audio Correlations and of day analysis **

%% [stats] = DU_CalAud(data)

%--------=======[  Batch Functions ]=======--------%
 %% this is what will go in the paper...

% For all the Undirected/Directed processing and stats:
DU_analysis_190729 % up-to-date data is in the dropbox

% For all the Undirected processing and stats:

DU_FinFig_01% up to date data is on Typhos Liberti_archive/Dropout_paper_Final_figure)data/processed.



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

% DU_a_Long_Coffin

% Final figure analysis for the Directed/Undirected paper.. can we find, through regression analysis,
% Any correlation between the song and the Calcium data?




%%%%[ Use Longitudinal Data ] %%%%

% Take data that is already formatted, and run a regression on it

% Load in data, and get the relevant features.

% INSCOPIX DATA
[Gconsensus3,CalciumDat,WARPED_TIME,WARPED_audio,idex,f,t] =  Inscopix_regression(ROI_data_cleansed);

% FREEDOMSCOPE DATA
 %  ** TO DO **


% Identify peaks and putaive spike times in Ca data usein deconvolveCa.m, to constrict where to look
% For regression

  % Method 1: Use average of Ca (~Long Lab) [peak times/window and heights]

  % Method 2: Build histogram of all trials, then threshold this value. [peak times/window and heights]



% ** Run a basic regression from the the 'song similarity' in this window [peak times/window and heights]


% ** Run a basic regression from the the 'song timing change' in this window [peak times/window and heights]


% Run a basic regression on the spectrograms, constrained by the spike window [peak times/window and heights]


% Are there any correlations across days in the changes in spectorgrams? Do these match changes in Ca?
    % Analyis 1: Across days, are there noticeable differences in song? Where to they occur?
















%% EXTRA ANALYSIS ( using the directed undirected dataset)
% Load data

% Get audio Vectors, and index
[audioVect,audioVect2,Index] =  DirUndir_Compare02(song_r,align,TEMPLATE);

% extract calcium data
[data] = FS_Data(calcium,align,Motif_ind,0,32);

% Get the concensus contour ( SDI)
[Gconsensus,f,t] = CY_Get_Consensus(audioVect2);

% find zeros, and remove them...
excl = find(Index{1} ==0)

data.ind_sort = data.raw_unsorted;
data.ind_sort(excl,:,:) = [];

% make a chance level sort
[Rerr, XMerr] = scrap_sort_gcon(Gconsensus);

%
RHO_Compare

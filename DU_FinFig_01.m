function DU_FinFig_01
% Build final figures from aggregated data...



% Default params ( if not passed as inputs)
frame_rates = [25 25 30] % vid frame rate can be different...

pad_prior = 100; % pad for sound ( 100ms)
pad_after = 0;

  % get all folders, save final processed folder

  % Initialize:
  START_DIR_ROOT = cd; % or a scheduled folder...
  if exist('Processed','file') >=0;;
   mkdir('Processed');
  end
  %

  % Run through everything

  % Get a list of all files and folders in this folder.

  files = dir(pwd);
  files(ismember( {files.name}, {'.', '..','Processed'})) = [];  %remove . and .. and Processed

  % Get a logical vector that tells which is a directory.
  dirFlags = [files.isdir];
  % Extract only those that are directories.
  subFolders = files(dirFlags);
  % Print folder names to command window.
  for k = 1 : length(subFolders)
  	fprintf('Sub folder #%d = %s\n', k, subFolders(k).name);
  end



  % index into all folders: load data, and run processing... Run through all folder...
    for i = 1:length(subFolders);
    disp(['entering folder  ', char(subFolders(i).name)])
    cd([subFolders(i).name,'/processed'])

load('input_data.mat');



[out{k}] = tempScrap(s,c,Gconsensus3,D2,t);


cd(START_DIR_ROOT);
  end

for i = 1: size(out)
if i ==1;
sim_score = out{i}.sim_score;
DffHeight = out{i}.DffHeight;
ChoppedAvect = out{i}.ChoppedAvect;
DffIntegrate = out{i}.DffIntegrate;
amplitude_score = out{i}.amplitude_score;
ChoppedGcon = out{i}.ChoppedGcon;
else
  sim_score = [sim_score,out{i}.sim_score]
  DffHeight = [DffHeight,out{i}.DffHeight];
  ChoppedAvect = [ChoppedAvect,out{i}.ChoppedAvect];
  DffIntegrate = [DffIntegrate. out{i}.DffIntegrate];
  amplitude_score = [amplitude_score, out{i}.amplitude_score];
  ChoppedGcon = [ChoppedGcon,out{i}.ChoppedGcon];
end
end

 Block_Sort(sim_score,DffHeight,ChoppedAvect,DffIntegrate,amplitude_score, ChoppedGcon);


  %Block_Sort(sim_score,DffHeight,ChoppedAvect,DffIntegrate,amplitude_score, ChoppedGcon);



  % Save figures, and output functions with params concatnated

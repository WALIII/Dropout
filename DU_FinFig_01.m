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



[out{i}] = tempScrap(s,c,Gconsensus3,D2,t);


cd(START_DIR_ROOT);
    end

  for cho = 2;
for i = 1: size(out,2)
    
        out2 =  Block_Sort(out{i}.sim_score,out{i}.DffHeight,out{i}.ChoppedAvect,out{i}.DffIntegrate,out{i}.amplitude_score, out{i}.ChoppedGcon, cho);

if i ==1;
At = out2.At;
Bt = out2.Bt;
Ct = out2.Ct;
Dt = out2.Dt;
Et = out2.Et;
else
At = cat(1,At, out2.At);
Bt = cat(1,Bt, out2.Bt);
Ct = cat(1,Ct,out2.Ct);
Dt = cat(1,Dt,out2.Dt);
Et = cat(1,Et,out2.Et);
end
end
DU_BoxPlot_FF(At,Bt,Ct,Dt,Et);


  end


  %Block_Sort(sim_score,DffHeight,ChoppedAvect,DffIntegrate,amplitude_score, ChoppedGcon);



  % Save figures, and output functions with params concatnated

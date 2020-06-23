function DU_CNMFe_organizeData

% index into all processed folders to get the ROI data, and export it in
% the right format

% TO DO: Background...

mkdir('processed');
homeDir = pwd;

% Get all folders in directory
files = dir(pwd);
files(ismember( {files.name}, {'.', '..','processed'})) = [];  %remove . and .. and Processed

% Get a logical vector that tells which is a directory.
dirFlags = [files.isdir];
% Extract only those that are directories.
subFolders = files(dirFlags);
% Print folder names to command window.
for k = 1 : length(subFolders)
    fprintf('Sub folder #%d = %s\n', k, subFolders(k).name);
end


for i = 1:length(subFolders);
    % index into folders,
    
    cd([subFolders(i).folder,'/',subFolders(i).name]);
    
    % Get all folders in directory
files2 = dir(pwd);
files2(ismember( {files2.name}, {'.', '..','template'})) = [];  %remove . and .. and Processed
dirFlagss = [files2.isdir];

subFolders2 = files2(dirFlagss);

disp('Loading Data...');
    cd([subFolders2(1).folder,'/',subFolders2(1).name,'/mat/processed2']);
   out =  load('Processed_Data','out');     out = out.out;
   load('results.mat');

Data{i}.BirdID = subFolders2(1).name;
Data{i}.ROI = out.aligned;
Data{i}.ROI_A = results.A;
Data{i}.Background = results.X;

clear out results
cd(homeDir)

end

save('processed/AllData.mat',Data);
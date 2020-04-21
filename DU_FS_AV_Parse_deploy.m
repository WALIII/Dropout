function DU_FS_AV_Parse_deploy




HomeDir = cd;
% Get all folders in directory
files = dir(pwd);
files(ismember( {files.name}, {'.', '..','template'})) = [];  %remove . and .. and Processed

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
    
     %   extract .mov files:
       FS_AV_Parse();
end

cd(HomeDir);
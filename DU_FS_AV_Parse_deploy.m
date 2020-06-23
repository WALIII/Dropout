function DU_FS_AV_Parse_deploy(varargin)

% windows: DU_FS_AV_Parse_deploy('cnmfe',1)
AVparse = 0;
cnmfe = 0;
nparams=length(varargin);

if mod(nparams,2)>0
    error('Parameters must be specified as parameter/value pairs');
end

for i=1:2:nparams
    switch lower(varargin{i})
        case 'cnmfe'
            cnmfe=varargin{i+1};
        case 'avparse'
            av=varargin{i+1};
    end
end

HomeDir = cd;
T = load([HomeDir,'/template/template_data']);

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
    if exist('mat')<1 && avparse ==1;
        FS_AV_Parse();
    elseif cnmfe == 1 
        cd('mat');
        [out,metadata] = DU_CNMFE;
        
        metadata.TEMPLATE = T.TEMPLATE;
        
        % 3. find songs ( Load Template data)
        [out.index.song_start, out.index.song_end, out.index.score_d] = find_audio(out.audio_data, metadata.TEMPLATE, 48000, 'match_single', false);
        
        load('results.mat');
        % 4. Align everything
        [out] =  DU_Align_Combined(out,out.index.song_start,out.index.song_end,results);
        
        
        % save data
        save('Processed_Data.mat','out','metadata');
    end
end
    
    cd(HomeDir);
function  FS_Prune()

% go through gif folders, and eliminate traces
% Step one: Load in ROIs for the day.

% run in mov dir 
DIR = pwd;

cleanDir = [pwd, '/','bad_trials'];
mkdir(cleanDir)

  nextDir = strcat(DIR,'/gif')

 cd(nextDir);

     gifListing = dir(fullfile(pwd,'*gif'));
     gifListing = {gifListing(:).name};
     for ii = 1:length(gifListing);
     gifListing2{ii} = gifListing{ii}(1:end-4);
     end
     
     disp('Extracting good gif trials');
    
     
     cd(DIR);
     
nextDir = strcat(DIR,'/mov')
cd(nextDir)

     movListing = dir(fullfile(pwd,'*mat'));
     movListing = {movListing(:).name};
     for ii = 1:length(movListing);
     movListing2{ii} = movListing{ii}(1:end-4);
     end

for i = 1:length(movListing2);
T = ismember(movListing2{i},gifListing2)

if T ==0;
    movefile(movListing{i},cleanDir)
end;
end;
     



     
% for ii = 1:length(ROI_dat{i}.filename)
         
% 
% s1 = movListing2
% s2 = gifListing2;
% tf = strcmp(s1,s2);
% disp(max(tf));
% clear s1; clear s2; 

     cd(DIR);




function FS_Move(directed, undirected)

% Move STD images to their proper place.



mkdir('undirected')
mkdir('directed')

mov_listing=dir(fullfile(pwd,'*.tif'));
filenames={mov_listing(:).name};


for i=1:length(filenames)
    
    for ii = 1:(size(directed,2))
     if filenames{i}(1:17) == directed{ii}(1:17)
    copyfile(filenames{i},'directed')
     else
         continue
     end
    end
    
     for ii = 1:(size(undirected,2))
     if filenames{i}(1:17) == undirected{ii}(1:17)
    copyfile(filenames{i},'undirected')
     else
         continue
     end
    end
    
    
   
end


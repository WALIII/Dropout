function FS_Move(directed, undirected)

% Move STD images to their proper place.



mkdir('undirected')
mkdir('directed')

for i = 1:size(directed,2)
    
    filename = [directed{i}(1:end-4) '_STD.tif'];
    
    copyfile(filename,'directed')
    clear filename;
   
end

for i = 1:size(undirected,2)
    
    filename = [undirected{i}(1:end-4) '_STD.tif'];
    
    copyfile(filename,'undirected')
    clear filename;
   
end

    


    
    
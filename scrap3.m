function [numBlobs] = SF_CellDetect(data)


resize = 1;
EstNumCells = 3000;




hblob = vision.BlobAnalysis( ...
                'AreaOutputPort', false, ...
                'BoundingBoxOutputPort', false, ...
                'OutputDataType', 'single', ...
                'MinimumBlobArea', 0, ...
                'MaximumBlobArea', 8, ...
                'Connectivity', 4, ...
                'MaximumCount', EstNumCells*1.5);
            
            
            image = imresize(data,resize);
            

    % Apply a combination of morphological dilation and image arithmetic
    % operations to remove uneven illumination and to emphasize the
    % boundaries between the cells.
    y1 = 2*image - imdilate(image, strel('square',7));
    y1(y1<0) = 0;
    y1(y1>30) = 1;
    y2 = imdilate(y1, strel('square',7)) - y1;

    
    th = graythresh(y2);      % Determine threshold using Otsu's method
    y3 = (y2 <= th*0.7); 
    
%     y4 = imgaussfilt(y3,2);
    

    Centroid = step(hblob, y3);   % Calculate the centroid
    numBlobs = size(Centroid,1);  % and number of cells.
    % Display the number of frames and cells.
    frameBlobTxt = sprintf('Frame %d, Count %d', 'one', numBlobs);
    image = insertText(image, [1 1], frameBlobTxt, ...
            'FontSize', 16, 'BoxOpacity', 0, 'TextColor', 'white');
    image = insertText(image, [1 size(image,1)],'wtf is this', ...
            'FontSize', 10, 'AnchorPoint', 'LeftBottom', ...
            'BoxOpacity', 0, 'TextColor', 'white');

    % Display video
    image_out = insertMarker(image, Centroid, 'o','Size',4*resize,'Color', 'green');
    
    figure(); imshow(image_out)
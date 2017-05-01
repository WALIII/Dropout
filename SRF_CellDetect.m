function  [ Centroid, numBlobs] = SRF_CellDetect(data)

hblob = vision.BlobAnalysis( ...
                'AreaOutputPort', false, ...
                'BoundingBoxOutputPort', false, ...
                'OutputDataType', 'single', ...
                'MinimumBlobArea', 0, ...
                'MaximumBlobArea', 100, ...
                'Connectivity', 8, ...
                'MaximumCount', 15000);
            
            
            image = imresize(data,1);
            

    % Apply a combination of morphological dilation and image arithmetic
    % operations to remove uneven illumination and to emphasize the
    % boundaries between the cells.
    y1 = 2*image - imdilate(image, strel('square',7));
    y1(y1<0) = 0;
    y1(y1>10) = 1;
    y2 = imdilate(y1, strel('square',7)) - y1;

    
    th = graythresh(image);      % Determine threshold using Otsu's method
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
    image_out = insertMarker(image, Centroid, 'o','Size',4,'Color', 'green');
    
    counter = 1;
    % Get rid of nearby ROIs by merging them

D = pdist(Centroid);

    %# find the indices corresponding to each distance
tmp = ones(size(Centroid,1));
tmp = tril(tmp,-1); %# creates a matrix that has 1's below the diagonal

%# get the indices of the 1's
[rowIdx,colIdx ] = find(tmp);

%# create the output
out = [D',Centroid(rowIdx,:),Centroid(colIdx,:)];

[B,I] = sort(out(:,1),1);

% set a threshold
GG = find(out2(:,1)<6);

%% TO DO: merge close cells...
for i = 1:size(GG);
    GH = out2(1,:,:,:)
    a
    b
    c
    d
    
    X(i,:) = out2(i,1


    
    
    figure(); imshow(image_out)
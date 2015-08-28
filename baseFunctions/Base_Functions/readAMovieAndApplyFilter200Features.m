function [newDataSet,interestFrameNumbers,interestPointValues] =  readAMovieAndApplyFilter200Features(fileAddress,gaussianFilterXSize,gaussianFilterYSize,taw,omega,timeFilterSize,localMaximumXSize,localMaximumYSize,localMaximumTimeSize,dataXSize,dataYSize,dataZSize)

    obj = VideoReader(fileAddress);
    [frames,nFrames] = selectAllFrames(obj); 
    framesCounter = 1;
    interestFrameNumbers = zeros(200,1);
    interestPointValues = zeros(200,2);
    vidHeight = obj.Height;
    vidWidth = obj.Width;
    middleFrame = floor(localMaximumTimeSize/2)+1;
%     width = vidWidth/4;
%     height = vidHeight/4;
    width = vidWidth;
    height = vidHeight;
    neededFramesNumber =  floor(timeFilterSize/2)+floor(localMaximumTimeSize/2);    
    numberOfFrames = max(2 * neededFramesNumber+1,dataZSize);
    mov = zeros(height,width,numberOfFrames,'uint8');
    movData = zeros(height,width,dataZSize,'uint8');
    [gaborFilterEV,gaborFilterOD] = gaborFilter(-floor(timeFilterSize/2),floor(timeFilterSize/2),omega,taw);
%     for j = neededFramesNumber:numberOfFrames'
%     movDataCounter = dataZSize-numberOfFrames+1;
%     movDataCounter = 1;
    
    for j = 1:numberOfFrames
        frame = read(obj,frames(framesCounter));
        framesCounter = framesCounter + 1;
        mov(:,:,j) = preprocessFrames(frame,1,0);%the last zeros is shouldResizeVariableOfFrames
    end
%     movData(:,:,1:10) =  mov(:,:,3:12);
    movData(:,:,1:dataZSize) =  mov(:,:,:);
    next = numberOfFrames + 1;
    result = zeros(height,width,numberOfFrames,'uint8');
%     for i = neededFramesNumber:numberOfFrames
    for i = 1:numberOfFrames
        result(:,:,i) = passGaussianFilterOnImage(mov(:,:,i),gaussianFilterXSize,gaussianFilterYSize,2);
    end
    % frames are turned into graylevel resized and gaussian passed and frames are at their place
    counter = 1;
    cubes = cell(1,200);
    cubesValues = -ones(1,200);
    for f = 1:nFrames
        fprintf('%d\n',floor(f*100/nFrames));
        finalResult = zeros(height,width,numberOfFrames);
        fprintf('Time to pass gabor: \n');
        tic;
        for i = 1:height
            for j=1:width
                r1 = zeros(1,numberOfFrames);
                r1(:) = result(i,j,:);
                result1 = conv(r1,gaborFilterEV,'same');
                result2 = conv(r1,gaborFilterOD,'same');
                finalResult(i,j,:) = result1.^2 + result2.^2;
            end
        end
        toc;
        fprintf('\n');
        
        fprintf('time to find interest points and cubes:\n');
        tic;
        [interestPoints,interestPointsValues] = findMaximumInOneFrame(finalResult(:,:,[ceil(numberOfFrames/2)-floor(localMaximumTimeSize/2):ceil(numberOfFrames/2)+floor(localMaximumTimeSize/2)]),localMaximumXSize,localMaximumYSize,localMaximumTimeSize,middleFrame,0);
        %          finalResult(:,:,:)
        %         [ceil(numberOfFrames/2)-floor(localMaximumTimeSize/2):ceil(numberOfFrames/2)+floor(localMaximumTimeSize/2)]
%  what if we use prparedMov instead of finalResult
        interestPoints = interestPoints(find(interestPointsValues > min(cubesValues)),:);
        interestPointsValues = interestPointsValues(find(interestPointsValues > min(cubesValues)));
        [interestPointsValues,tempIndices] = sort(interestPointsValues);
        interestPoints = interestPoints(tempIndices,:);
        [interestedCubes] = findCubes(movData,interestPoints,dataXSize,dataYSize,dataZSize);
        toc;
        fprintf('\n');
        if ~isempty(interestedCubes)
            for ipvc = length(interestPointsValues):-1:1
                if interestPointsValues(ipvc) > cubesValues(1)
                    cubesValues(1) = interestPointsValues(ipvc);
                    cubes{1} = interestedCubes{ipvc};
                    interestFrameNumbers(1) = f+floor(next/2)-1;
                    interestPointValues(1,:) = interestPoints(ipvc,1:2);
                    [cubesValues,sortedIndicesValues] = sort(cubesValues);
                    cubes = cubes(sortedIndicesValues);
                    interestFrameNumbers = interestFrameNumbers(sortedIndicesValues);
                    interestPointValues = interestPointValues(sortedIndicesValues,:);    
                end
                
            end
%             originalPoints(counter:counter+length(interestedCubes)-1) = originalPointsInThatFrame;
%             counter = counter+length(interestedCubes);
        end
        fprintf('The number of cubes is equal to:%d\n',length(cubes));
        result = circshift(result,[0 0 -1]);
        movData = circshift(movData,[0 0 -1]);
        if next <= nFrames
            nextFrame = read(obj,frames(framesCounter));
            framesCounter = framesCounter + 1;
            result(:,:,numberOfFrames) = preprocessFrames(nextFrame,1,0);
            movData(:,:,dataZSize) = result(:,:,numberOfFrames);
            result(:,:,numberOfFrames) = passGaussianFilterOnImage(result(:,:,numberOfFrames),gaussianFilterXSize,gaussianFilterYSize,2);
            next = next + 1;
        else
            break;
%             movData(:,:,dataZSize) = zeros(height,width);
%             result(:,:,numberOfFrames) = zeros(height,width);
        end
    end
    if ~isempty(cubes{1})
        [newDataSet] = changeCubesToDataSet(cubes,13,13,10);
    else
        newDataSet = [];
        interestFrameNumbers = [];
        interestPointValues = [];
    end
    
end
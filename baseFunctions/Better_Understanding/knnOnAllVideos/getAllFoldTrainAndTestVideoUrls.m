function [trainUrls, trainClasses, testUrls, testClasses] = getAllFoldTrainAndTestVideoUrls(baseDataSetAddress, foldNumber, numberOfFolds)
    trainUrls = {};
    trainClasses = [];
    testUrls = {};
    testClasses = [];
    allClasses = dir(baseDataSetAddress);
    allClasses(1:2) = [];
    for i = 1:length(allClasses)
        allClassVideos = dir(strcat(baseDataSetAddress, allClasses(i).name));
        allClassVideos(1:2) = [];
        theNumberOfVideos = length(allClassVideos);
        videoNumbers = 1:theNumberOfVideos;
        foldLength = floor(theNumberOfVideos / numberOfFolds);
        beginOfInterval = (foldNumber - 1) * foldLength + 1;
        endOfInterval = foldNumber * foldLength;
        testVideoNumbers = beginOfInterval:endOfInterval;
        biggestVideoNumber = foldLength * numberOfFolds;
        if biggestVideoNumber + foldNumber <= theNumberOfVideos
            testVideoNumbers = [testVideoNumbers, biggestVideoNumber + foldNumber];
        end
        videoNumbers(testVideoNumbers) = [];
        allTrainVideos = allClassVideos(videoNumbers);
        allTestVideos = allClassVideos(testVideoNumbers);
        for j = 1:length(allTrainVideos)
            trainUrls{end + 1} = strcat(baseDataSetAddress, allClasses(i).name, '/', allTrainVideos(j).name);
            trainClasses(end + 1) = i;
        end
        for j = 1:length(allTestVideos)
            testUrls{end + 1} = strcat(baseDataSetAddress, allClasses(i).name, '/', allTestVideos(j).name);
            testClasses(end + 1) = i;
        end
    end
end
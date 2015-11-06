function classesOfVideos = findClassesByKNearestNeighbour(k, testUrls, trainUrls, trainClasses)
    theNumberOfVideoWords = 200;
    theFeatureOfEachVideo = 1695;
    theNumberOfTrainVideos = length(trainUrls);
    theNumberOfTestVideos = length(testUrls);
    testVideos = int16(zeros(theNumberOfVideoWords * theNumberOfTestVideos, theFeatureOfEachVideo));
    for i = 1:theNumberOfTestVideos
        testVideo = importdata(testUrls{i});
        testVideos((i - 1) * theNumberOfVideoWords + 1: i * theNumberOfVideoWords, :) = testVideo;
    end
    
    distanceMatrix = zeros(theNumberOfTestVideos, theNumberOfTrainVideos);
    for i = 1:theNumberOfTrainVideos
        fprintf('%0.3f percent completed.\n', i / theNumberOfTrainVideos * 100)
        trainVideo = importdata(trainUrls{i});
        for j = 1:theNumberOfTestVideos
            distanceMatrix(j, i) = calDist(testVideos((j - 1) * theNumberOfVideoWords + 1:j * theNumberOfVideoWords ,:), trainVideo);
        end
    end
    for i = 1:theNumberOfTestVideos
        [~, nearestVideoNumbers] = sort(distanceMatrix(i, :));
        classesOfVideos(i) = mode(trainClasses(nearestVideoNumbers(1:k)));
    end
end
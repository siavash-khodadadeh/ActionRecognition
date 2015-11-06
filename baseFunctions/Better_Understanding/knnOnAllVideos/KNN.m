function accuracyVector = KNN(baseDataSetAddress, k, numberOfFolds)
    accuracyVector = zeros(1, numberOfFolds);
%     for i = 1:numberOfFolds
    for i = 1:1
        [trainUrls, trainClasses, testUrls, testClasses] = getAllFoldTrainAndTestVideoUrls(baseDataSetAddress, i, numberOfFolds);
        accuracy = knnOnVideos(k, trainUrls, trainClasses, testUrls, testClasses);
        accuracyVector(i) = accuracy;
    end
end
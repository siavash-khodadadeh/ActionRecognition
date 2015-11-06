function accuracy = knnOnVideos(k, trainUrls, trainClasses, testUrls, testClasses)
    classesOfTestVideos = findClassesByKNearestNeighbour(k, testUrls, trainUrls, trainClasses);
    accuracy = sum(classesOfTestVideos == testClasses) / length(testUrls);
end
function distanceOfVideos = calDist(testVideo, trainVideo)
    addpath('../../Base_Functions/');
    distanceOfVideos = 0;
    trainVideo = trainVideo(:, 2:1691);
    trainVideo = getFlattendGradientData(trainVideo, 13, 13, 10);
    testVideo = testVideo(:, 2:1691);
    testVideo = getFlattendGradientData(testVideo, 13, 13, 10);
    for i = 1:size(trainVideo, 1)
        distanceOfVideos = distanceOfVideos + sum((trainVideo(i, :) - testVideo(i, :)) .^ 2);
    end
end
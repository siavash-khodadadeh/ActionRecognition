clear;
clc;
videoAddress = '../data/dataset/boxing/boxing_1.alldata';
clusterDataAddress = '../data/all_folds/25-folds-correct/fold1.clusters';
clusterData = importdata(clusterDataAddress);
videoData = importdata(videoAddress);
videoTimeData = zeros(size(videoData, 1), 1);
for i = 1:size(videoData, 2)
    wordNumber = findWord(videoData(i, 2: 1691), clusterData)
    videoTimeData(i, :) = [wordNumber, videoData(i, 1692)];
end
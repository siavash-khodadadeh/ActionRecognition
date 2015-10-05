k = 3;
dataAddress = '../../../data/word2vec_data/';
classes = {'boxing', 'handclapping', 'handwaving', 'jogging', 'running', 'walking'};
trainVideoNumbers = [1, 2, 3, 4, 5];
trainVideoClasses = [1, 1, 1, 1, 1];
testVideoNumbers = [6];

distanceToTrainVideos = zeros(1, length(trainVideoNumbers));
guessedClasses = zeros(1, length(testVodeoNumbers));
for i = 1:length(testVideoNumbers)
    testVideoAddress = '';
    for j=1:length(trainVideoNumbers)
        trainVideoAddress = '';
        distanceToTrainVideos(j) = calculateDistanceOf2Videos(testVideoAddress, trainVideoAddress);
    end
    [~, indices] = sort(ditanceToTrainVideos);
    indices = indices(1:k);
    guessedClasses(i) = mode(indices);
end

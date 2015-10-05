function nearestWords = findNearestInWord2Vec(word)
    allWordsData = importdata('../../../data/word2vec_data/allWordsVectors.txt');
    distanceData = dist(allWordsData);
    wordDistanceFromOtherWords = distanceData(word, :);
    [~, sortedIndices] = sort(wordDistanceFromOtherWords);
    nearestWords = sortedIndices(2:11);
end

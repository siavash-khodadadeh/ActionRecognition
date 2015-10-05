clear;
clc;
address = '../../../data/word2vec_data/featureVectors.txt';
allWordsVectors = importdata(address);
allWordsVectors = allWordsVectors.data;
allWordsVectors(1:200) = [];
allWordsData = zeros(200, 1000);
rowNumber = 1;
while rowNumber < size(allWordsVectors, 1)
    allWordsData(:, allWordsVectors(rowNumber)) = allWordsVectors(rowNumber + 1: rowNumber + 200);
    rowNumber = rowNumber + 201;
end
save('../../../data/word2vec_data/allWordsVectors.txt' ,'allWordsData', '-ascii');

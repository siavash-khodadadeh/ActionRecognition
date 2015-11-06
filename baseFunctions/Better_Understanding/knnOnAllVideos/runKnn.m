clear;
clc;
numberOfFolds = 10;
k = 5;
baseDataSetAddress = '../../../data/dataset/';
accuracyVector = KNN(baseDataSetAddress, k, numberOfFolds);
for i = 1:numberOfFolds
    fprintf('The fold %d accuracy: %0.3f\n', i, accuracyVector(i));
end
fprintf('The mean accuracy: %0.3f\n', mean(accuracyVector))
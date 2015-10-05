tic;
clear;
clc;
allVideoNumbers = 599;
addpath('../baseFunctions/Base_Functions');
baseDataSetAddress = '../data/dataset/';
tempclasses = dir(baseDataSetAddress);
tempclasses(1:2) = [];
counterClasses = 1;
numberOfDictionaryWords = 1000;
for i = 1:length(tempclasses)
    if tempclasses(i).isdir == 1
        classes{counterClasses} = tempclasses(i);
        counterClasses = counterClasses + 1;
    end
end

%this part is 10 fold cross validation
numberOfFolds = 25;
delete(gcp('nocreate'));
matlabpool open 16;
parfor i = 1:numberOfFolds
% for i = 1:1
    trainSet = [];
    testSet = [];
    offSet = 0;
    allTrainNumbers = [];
    allTestNumbers = [];
    for j = 1:length(classes)
        allFiles = dir(strcat(baseDataSetAddress,classes{j}.name));
        allFiles(1:2) = [];
        trainSetNumbers = 1:length(allFiles);
        theNumberOfAllVideos = length(allFiles);
        foldLength = floor(theNumberOfAllVideos / numberOfFolds);
        foldNumbers = 1 + (i - 1) * foldLength:i * foldLength;
        if i <= rem(theNumberOfAllVideos, numberOfFolds)
            foldNumbers = [foldNumbers, numberOfFolds * foldLength + i];
        end
        foldNumbers = floor(foldNumbers);
        testSetNumbers = (foldNumbers);
        trainSetNumbers(foldNumbers) = [];
%         clear k;
        k = [];
        for k = 1:length(trainSetNumbers)
            data = importdata(strcat(baseDataSetAddress, classes{j}.name, '/', allFiles(trainSetNumbers(k)).name));
            trainSet = [trainSet; data];
            fprintf('%.3f percent of train videos completed\nClass = %s\n', k / length(trainSetNumbers) * 100, classes{j}.name);
        end
        for k = 1:length(testSetNumbers)
            data = importdata(strcat(baseDataSetAddress,classes{j}.name, '/', allFiles(testSetNumbers(k)).name));
            testSet = [testSet;data];
            fprintf('%.3f percent of test videos completed\n', k / length(testSetNumbers) * 100);
        end
        allTrainNumbers = [allTrainNumbers,trainSetNumbers + offSet];
        allTestNumbers = [allTestNumbers,testSetNumbers + offSet];
        offSet = offSet + theNumberOfAllVideos;
    end
    % Now we have the trainset and testset
    videoNumbers = trainSet(:,1);
    times = trainSet(:,1694);
    trainClasses = trainSet(:,1695);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
    pointValues = trainSet(:,[1692,1693]);
    dataSet = trainSet;
    dataSet(:,[1,[1692:1695]]) = [];
    dataSet = double(dataSet);
    fprintf('Applying principal components analysis\nThis may be time consuming\n');                                                                                                                                                                                                                                                                                                                tic;
    coeff = princomp(dataSet);
    newDataSet = dataSet * coeff;
    newDataSet = newDataSet(:, 1:100);
%     clear dataSet;
    dataSet = [];
    toc;
    fprintf('Making dictionary words\n');
    tic;
    [idx, clusters] = makeDictionaryWords(newDataSet,numberOfDictionaryWords);
    newDataSet = [double(videoNumbers), newDataSet, double(pointValues), double(times), double(trainClasses)];
    temp = [double(videoNumbers), idx, double(pointValues), double(times), double(trainClasses)];
    toc;
    
    finalData = zeros(allVideoNumbers, numberOfDictionaryWords);
    
    testVideoNumbers = testSet(:,1);
    testTimes = testSet(:,1694);
    testClasses = testSet(:,1695);
    testPointValues = testSet(:, [1692,1693]);
    testDataSet = testSet;
    testDataSet(:,[1, [1692:1695]]) = [];
    testDataSet = double(testDataSet);
    newTestDataSet = testDataSet * coeff;
    newTestDataSet = newTestDataSet(:, 1:100);
%     clear testDataSet;
    testDataSet = [];
    tempTest = zeros(size(newTestDataSet, 1), 1);
    for q = 1:size(newTestDataSet, 1)
        tempTest(q) = findWord(newTestDataSet(q, :), clusters);
    end
    
    tempTest = [double(testVideoNumbers), tempTest, double(testPointValues), double(testTimes), double(testClasses)];
    temp = [temp;tempTest];
%     clear tempTest;
     tempTest = [];
%     counter = 0;
    for w = 1:allVideoNumbers
        for q = 1:numberOfDictionaryWords
            finalData(w, q) = sum(min(temp(:, 1)==w, temp(:, 2) == q));
        end
    end
    
    finalClasses = [ones(100, 1); 2 * ones(99, 1); 3 * ones(100, 1); 4 * ones(100, 1); 5 * ones(100, 1); 6 * ones(100, 1)];
    
   
    trainData = finalData(allTrainNumbers ,:);
    trainClasses = finalClasses(allTrainNumbers, :);
    testData = finalData(allTestNumbers, :);
    testClasses = finalClasses(allTestNumbers, :);
    saveFoldData(trainData, trainClasses, testData, testClasses, clusters, temp, coeff, videoNumbers, testVideoNumbers, i);
%     save(strcat('fold',num2str(i),'.trainData'),'trainData');
%     save(strcat('fold',num2str(i),'.trainClasses'),'trainClasses');
%     save(strcat('fold',num2str(i),'.testData'),'testData');
%     save(strcat('fold',num2str(i)','.testClasses'),'testClasses');
%     createDiffusionModel(trainData,trainClasses,testData,testClasses);
%     [tempknn] = knnclassify(testData,trainData,trainClasses,3,'cityblock')
    
end
delete(gcp('nocreate'));
toc;




% allData = importdata('dataset/all.data');
% videoNumbers = allData(:,1);
% times = allData(:,1692);
% classes = allData(:,1693);
% allData(:,[1,1692,1693]) = [];
% dataSet = allData;
% coecff = princomp(dataSet);
% newDataSet = dataSet * coeff;
% newDataSet = newDataSet(:,1:100);
% clear dataSet;
% newDataSet = [videoNumbers,newDataSet,times,classes];
% save(strcat(baseFeatureDataSetAddress,'all.data'),'newDataSet');
% toc;

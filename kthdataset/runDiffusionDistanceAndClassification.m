clear;
clc;
addpath('../baseFunctions/Base_Functions');
numberOfFolds = 25;
p = 3;
sigmaValue = 3;
numberOfSemanticWords = 500;
allFoldsAccuracyBeforeOurMethodKNN = [];
accuracyAfterOurMethodKNN = [];
allFoldsAccuracy = [];
allFoldsAccuracyBeforeSVM = [];
for i = 1:numberOfFolds
    fprintf('fold %d:\n',i);
    trainData = importdata(strcat('all_folds/',num2str(numberOfFolds),'-folds-correct/fold',num2str(i),'.trainData'));
    trainClasses = importdata(strcat('all_folds/',num2str(numberOfFolds),'-folds-correct/fold',num2str(i),'.trainClasses'));
    testData = importdata(strcat('all_folds/',num2str(numberOfFolds),'-folds-correct/fold',num2str(i),'.testData'));
    testClasses = importdata(strcat('all_folds/',num2str(numberOfFolds),'-folds-correct/fold',num2str(i),'.testClasses'));
    [tempknn] = knnclassify(testData,trainData,trainClasses,3,'cityblock');
    accuracy = sum (tempknn == testClasses)/length(testClasses);
    fprintf('KNN accuracy before semantic feature extraction: %0.4f\n',accuracy);
%     display(accuracy);
    allFoldsAccuracyBeforeOurMethodKNN = [allFoldsAccuracyBeforeOurMethodKNN,accuracy];
    recommendLabelsBefore = runSvmOnData(trainClasses,trainData,testData);
    errNumBefore = sum(recommendLabelsBefore ~= testClasses);
    accuracyBefore = 1 - (errNumBefore / length(testClasses));
    fprintf('SVM accuracy before semantic feature extraction: %0.4f\n',accuracyBefore)
%     display(accuracyBefore);
    allFoldsAccuracyBeforeSVM = [allFoldsAccuracyBeforeSVM, accuracyBefore];
    [semanticTraining,semanticTest] = createDiffusionModel(trainData,testData,numberOfSemanticWords,p,sigmaValue);
    a = knnclassify(semanticTest,semanticTraining,trainClasses,3,'cityblock');
    accuracy = sum(testClasses == a)/length(testClasses);
    fprintf('KNN accuracy after semantic feature extraction: %0.4f\n',accuracy)
%     display(accuracy);
    accuracyAfterOurMethodKNN = [accuracyAfterOurMethodKNN,accuracy];
%     c = [];
%     for k = 1:6
%         for j = k+1:6
%             a = find(trainClasses == k);
%             b = find(trainClasses == j);
%             runTimeError = 1;
%             while runTimeError == 1
%                 try
%                     svmLearner = svmtrain(semanticTraining([a;b],:),[ones(length(a),1);zeros(length(b),1)],'method','LS');
%                     runTimeError = 0;
%                 catch
%                     fprintf('--------------------------------------------\n----SVM could not converge--trying again----\n--------------------------------------------\n');
%                 end
%             end
%             c = [c,svmclassify(svmLearner,semanticTest)];
%         end
%     end
%     recommendLabels = [];
%     for l = 1:size(semanticTest,1)
%         rowVec = c(l,:);
%         counter = 1;
%         eachClassVotes = zeros(1,6);
%         for j =1:6
%             for k = j+1:6
%                 if rowVec(counter) == 1
%                     eachClassVotes(j) = eachClassVotes(j) + 1;
%                 else
%                     eachClassVotes(k) = eachClassVotes(k) + 1;
%                 end
%                 counter = counter + 1;
%             end
%         end
%         [val, index] = max(eachClassVotes);
%         recommendLabels = [recommendLabels;index];
%     end
%     accuracy = sum((testClasses==6) == a)/length(testClasses);
%     display(accuracy);
    recommendLabels = runSvmOnData(trainClasses,semanticTraining,semanticTest);
    errNum = sum(recommendLabels ~= testClasses);
    accuracy = 1 - (errNum / length(testClasses));
    allFoldsAccuracy = [allFoldsAccuracy,accuracy];
    fprintf('SVM accuracy after semantic feature extraction: %0.4f\n',accuracy)
    fprintf('------------------------------------------------------\n')
%     display(accuracy);

end
beforeKNN = mean(allFoldsAccuracyBeforeOurMethodKNN);
afterKNN = mean(accuracyAfterOurMethodKNN);
accuracyBeforeSVM =  mean(allFoldsAccuracyBeforeSVM);
accuracy = mean(allFoldsAccuracy);
fprintf('KNN accuracy before semantic feature extraction: %0.4f\n',beforeKNN)
% display(beforeKNN);
fprintf('KNN accuracy after semantic feature extraction: %0.4f\n',afterKNN)
% display(afterKNN);
fprintf('SVM accuracy before semantic feature extraction: %0.4f\n',accuracyBeforeSVM)
% display(accuracyBeforeSVM);
fprintf('SVM accuracy before semantic feature extraction: %0.4f\n',accuracy)
% display(accuracy);



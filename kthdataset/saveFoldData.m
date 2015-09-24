function saveFoldData(trainData, trainClasses, testData, testClasses, clusters, temporalData, pcaCoeffData, i)
    save(strcat('../data/all_folds/fold', num2str(i), '.trainData'), 'trainData');
    save(strcat('../data/all_folds/fold', num2str(i), '.trainClasses'), 'trainClasses');
    save(strcat('../data/all_folds/fold', num2str(i), '.testData'), 'testData');
    save(strcat('../data/all_folds/fold', num2str(i), '.testClasses'), 'testClasses');
    save(strcat('../data/all_folds/fold', num2str(i), '.clusters'), 'clusters');
    save(strcat('../data/all_folds/fold', num2str(i), '.temporalData'), 'temporalData');
    save(strcat('../data/all_folds/fold', num2str(i), '.pcaCoeffData'), 'pcaCoeffData');
end

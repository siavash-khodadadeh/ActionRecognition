function saveFoldData(trainData,trainClasses,testData,testClasses,clusters,temporalData,i)
    save(strcat('all_folds/fold',num2str(i),'.trainData'),'trainData');
    save(strcat('all_folds/fold',num2str(i),'.trainClasses'),'trainClasses');
    save(strcat('all_folds/fold',num2str(i),'.testData'),'testData');
    save(strcat('all_folds/fold',num2str(i),'.testClasses'),'testClasses');
    save(strcat('all_folds/fold',num2str(i),'.clusters'),'clusters');
    save(strcat('all_folds/fold',num2str(i),'.clusters'),'clusters');
    save(strcat('all_folds/fold',num2str(i),'.temporalData'),'temporalData');
end
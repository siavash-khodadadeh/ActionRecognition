function saveAllData(baseFeatureDataSetAddress,classes,j,dataSet,interestFrameNumbers,interestPointValues)
    save(strcat(baseFeatureDataSetAddress,classes,'/',classes,'_',num2str(j),'.table'),'dataSet','-ascii');
    save(strcat(baseFeatureDataSetAddress,classes,'/',classes,'_',num2str(j),'.timedata'),'interestFrameNumbers','-ascii');
    save(strcat(baseFeatureDataSetAddress,classes,'/',classes,'_',num2str(j),'.pointvalues'),'interestPointValues','-ascii');
end
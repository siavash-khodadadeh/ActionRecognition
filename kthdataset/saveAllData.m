function saveAllData(baseFeatureDataSetAddress,classes,j,dataSet,interestFrameNumbers,interestPointValues)
    try
        save(strcat(baseFeatureDataSetAddress,classes,'/',classes,'_',num2str(j),'.table'),'dataSet','-ascii');
    catch
        fprintf(strcat(baseFeatureDataSetAddress,classes,'/',classes,'_',num2str(j),'.table could not be saved.\n'))
    end
    try
        save(strcat(baseFeatureDataSetAddress,classes,'/',classes,'_',num2str(j),'.timedata'),'interestFrameNumbers','-ascii');
    catch
        fprintf(strcat(baseFeatureDataSetAddress,classes,'/',classes,'_',num2str(j),'.timedata could not be saved.\n'))
    end
    try
        save(strcat(baseFeatureDataSetAddress,classes,'/',classes,'_',num2str(j),'.pointvalues'),'interestPointValues','-ascii');
    catch
        fprintf(strcat(baseFeatureDataSetAddress,classes,'/',classes,'_',num2str(j),'.pointvalues could not be saved.\n'))
    end
end
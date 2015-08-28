function [IDX,clusters] = makeDictionaryWords(data,numberOfDictionaryWords)
%     baseFeatureDataSetAddress = '/media/siavash/01D00557EB1240C0/Matlab Workspace/MasterThesis/HumanActionRecognition/data/';
% 
%     data = importdata(strcat(baseFeatureDataSetAddress,'all.data'));
    [IDX, clusters] = kmeans(data,numberOfDictionaryWords,'distance','sqEuclidean');

%     save(strcat(baseFeatureDataSetAddress,'clusters.data'),'clusters');
%     save(strcat(baseFeatureDataSetAddress,'IDX.data'),'IDX');

end
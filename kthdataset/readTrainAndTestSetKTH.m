% function readTrainAndTestSetKTH()
% end
tic;
diary('../logs/readTrainAndTestSetKTH.log');
diary on;
clc;
clear;
delete(gcp('nocreate'));
matlabpool open 16;
addpath('../baseFunctions/Better_Understanding');
addpath('../baseFunctions/Base_Functions');
baseFileAddress ='../data/kthdataset_videos';
baseFeatureDataSetAddress = '../data/kthdata/';
gaussianFilterXSize = 13;
gaussianFilterYSize = 13;
taw = 1.5;
omega = 4 / taw;
class_boxing = 'boxing';
class_handclpping = 'handclapping';
class_handwaving = 'handwaving';
class_jogging = 'jogging';
class_running = 'running';
class_walking = 'walking';
classes = cell(1,6);
classes{1} = class_boxing;
classes{2} = class_handclpping;
classes{3} = class_handwaving;
classes{4} = class_jogging;
classes{5} = class_running;
classes{6} = class_walking;
[temp classesSize] = size(classes);
for i = 1:classesSize
    baseClassFileAddress = strcat(baseFileAddress,'/',classes{i},'/');
    allFileAddresses = dir(baseClassFileAddress);
    allFileAddresses(1:2) = [];
    parfor j = 1:length(allFileAddresses)
%     for j = 1:length(allFileAddresses)
%    for j = 1:4
        [fid,err] = fopen(strcat(baseFeatureDataSetAddress,classes{i},'/',classes{i},'_',num2str(j),'.table'));
        if ~isempty(err)
            fileAddress = strcat(baseClassFileAddress,allFileAddresses(j).name);
            timeFilterSize = 7;
            localMaximumXSize = 3;
            localMaximumYSize = 3;
            localMaximumTimeSize = 3;
            dataXSize = 13;%How many pixels are needed for descriptor around interest point in x direction
            dataYSize = 13;%How many pixels are needed for descriptor around interest point in y direction
            dataZSize = 10;%How many pixels are needed for descriptor around interest point in z direction
            [dataSet,interestFrameNumbers,interestPointValues] = readAMovieAndApplyFilter200Features(fileAddress,gaussianFilterXSize,gaussianFilterYSize,taw,omega,timeFilterSize,localMaximumXSize,localMaximumYSize,localMaximumTimeSize,dataXSize,dataYSize,dataZSize);
%             save(strcat(baseFeatureDataSetAddress,classes{i},'/',classes{i},'_',num2str(j),'.table'),'dataSet','-ascii');
%             save(strcat(baseFeatureDataSetAddress,classes{i},'/',classes{i},'_',num2str(j),'.timedata'),'interestFrameNumbers','-ascii');
%             save(strcat(baseFeatureDataSetAddress,classes{i},'/',classes{i},'_',num2str(j),'.pointvalues'),'interestPointValues','-ascii');
            saveAllData(baseFeatureDataSetAddress,classes{i},j,dataSet,interestFrameNumbers,interestPointValues);
        end
    end
%      delete(gcp('nocreate'));
end
delete(gcp('nocreate'));
diary off;
% firstFileNum = 101;
% lastFileNum = 326;
% allFileAddresses = dir(baseFileAddress);
% allFileAddresses(1:2) = [];
% tic;
% for i = firstFileNum:lastFileNum
%     [fId,err] = fopen(strcat(baseFeatureDataSetAddress,num2str(i),'.table'));
% %     if ~isempty(err)
%         fileAddress = strcat(baseFileAddress,allFileAddresses(i).name);
%         timeFilterSize = 7;
%         localMaximumXSize = 13;
%         localMaximumYSize = 13;
%         localMaximumTimeSize = 11;
%         [cubes] = readAMovieAndApplyFilter(fileAddress,gaussianFilterXSize,gaussianFilterYSize,taw,omega,timeFilterSize,localMaximumXSize,localMaximumYSize,localMaximumTimeSize);
%         dispaly([1]);
% %         [dataSet] = readAMoviePartByPartAndSaveDataset(fileAddress,gaussianFilterXSize,gaussianFilterYSize,taw,omega,timeFilterSize,localMaximumXSize,localMaximumYSize,localMaximumTimeSize);
% %         [dataSet] = readAMovieAndSaveDataset(fileAddress,gaussianFilterXSize,gaussianFilterYSize,taw,omega);
% %         save(strcat(baseFeatureDataSetAddress,num2str(i),'.table'),'dataSet');
% %     end
% end
% toc;
% % save and load
% 
% 
% % numberOfDictionaryWords = 100;
% % [IDX clusters] = kmeans(newDataSet,numberOfDictionaryWords,'distance','sqEuclidean');
% 
% % imshow(result(:,:,125));
toc;

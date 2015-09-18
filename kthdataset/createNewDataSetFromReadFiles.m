% should be run after readTrainAndTEstSetKTH
tic;
clc;
clear;
addpath('../baseFunctions/Base_Functions');
baseFileAddress = '../data/kthdata/';
baseFeatureDataSetAddress = '../data/dataset/';
tempclasses = dir(baseFileAddress);
tempclasses(1:2) = [];
counterClasses = 1;
for i = 1:length(tempclasses)
    if tempclasses(i).isdir == 1
        classes{counterClasses} = tempclasses(i);
        counterClasses = counterClasses + 1;
    end
end
emptyVideos = [];
% dataSet = [];
videoNumber = 1;
for i = 1:length(classes)
    baseClassFileAddress = strcat(baseFileAddress ,classes{i}.name);
    allFiles = dir(baseClassFileAddress);
    allFiles(1:2) = [];
    for j = 1:length(allFiles)
        if strfind(allFiles(j).name, '.table') > 0           
            if rem(videoNumber, 10) == 0
                fprintf('%d percent completed\n', round(videoNumber / 600 * 100));
            end
            data = importdata(strcat(baseClassFileAddress, '/', allFiles(j).name));
%             data = uint8(data);
            data = int16(data);
            if isempty(data)
                emptyVideos = [emptyVideos;videoNumber,i,j];
            else
                r = 13;
                c = 13;
                d = 10;
                data = getFlattendGradientData(data, r, c, d);
%                 data = uint8(data);
                data = int16(data);
                vNum = int16(videoNumber * ones(size(data ,1), 1));
                classNumber = int16(i * ones(size(data, 1), 1));
                timeData = importdata(strcat(baseClassFileAddress, '/', strrep(allFiles(j).name, '.table', '.timedata')));
                timeData = int16(timeData);
                timeData = timeData';
                pointValues = importdata(strcat(baseClassFileAddress, '/', strrep(allFiles(j).name, '.table', '.pointvalues')));
                pointValues = int16(pointValues);
                data = [vNum,data, pointValues, timeData', classNumber];
                save(strcat(baseFeatureDataSetAddress, classes{i}.name, '/' ,strrep(allFiles(j).name, '.table', '.alldata')), 'data');
                clear data;
                data = [];
%                 dataSet = [dataSet;data];
            end
            videoNumber = videoNumber + 1;
        end
    end
%     save(strcat(baseFeatureDataSetAddress,classes{i}.name,'_all.data'),'dataSet');
%     clear dataSet;
%     dataSet = [];
end
% coecff = princomp(dataSet);
% newDataSet = dataSet * coeff;
% newDataSet = newDataSet(:,1:100);
% save(strcat(baseFeatureDataSetAddress,'all.data'),'dataSet');
save(strcat(baseFeatureDataSetAddress, 'emptyVideos.data'), 'emptyVideos');
toc;

function checkFeatureFindingOfOneVideo(classNumberInput,videoNumberInput)
% put debug on line 43
    tic;
    clc;
    clear;
    classNumberInput = 1;
    videoNumberInput = 10;
    localComputerVideosAddress = '/media/siavash/01D00557EB1240C01/Master Thesis/KTH Database';
    addpath('../baseFunctions/Better_Understanding');
    addpath('../baseFunctions/Base_Functions');
    baseFileAddress =localComputerVideosAddress;
    baseFeatureDataSetAddress = 'kthdata_2/';
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
    for i = 1:classNumberInput
        baseClassFileAddress = strcat(baseFileAddress,'/',classes{i},'/');
        allFileAddresses = dir(baseClassFileAddress);
        allFileAddresses(1:2) = [];
        for j = videoNumberInput
            [fid,err] = fopen(strcat(baseFeatureDataSetAddress,classes{i},'/',classes{i},'_',num2str(j),'.table'));
            fileAddress = strcat(baseClassFileAddress,allFileAddresses(j).name);
            timeFilterSize = 7;
            localMaximumXSize = 13;
            localMaximumYSize = 13;
            localMaximumTimeSize = 9;
            dataXSize = 13;%How many pixels are needed for descriptor around interest point in x direction
            dataYSize = 13;%How many pixels are needed for descriptor around interest point in y direction
            dataZSize = 10;%How many pixels are needed for descriptor around interest point in z direction
            [dataSet,interestFrameNumbers,interestPointValues] = readAMovieAndApplyFilter(fileAddress,gaussianFilterXSize,gaussianFilterYSize,taw,omega,timeFilterSize,localMaximumXSize,localMaximumYSize,localMaximumTimeSize,dataXSize,dataYSize,dataZSize);
        end

    end
    toc;

end

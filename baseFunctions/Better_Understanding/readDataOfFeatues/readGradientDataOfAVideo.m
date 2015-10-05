clear;
clc;
addpath('../../baseFunctions/Base_Functions');
r = 13;
c = 13;
d = 10;
videoClass = 1;
videoNumber = 10;
[dataSet, pointValues, timeData] = loadDataOfAVideo(videoClass, videoNumber);
while 1==1
    clc;
    fprintf('Number of features is equal to: %d\n',size(dataSet,1));
    k = input('Select the number of feature which you want to see: ');
    if k == -1
        display('finished');
        break;
    end
    data = int16(dataSet(k,:));
    data = getFlattendGradientData(data,r,c,d);
    l = input('Select the number of frame you want to see or type 0 to show all: ');
    if l == 0
        te = reshape(data,[13,13,10]);
        for m = 1:10
            subplot(2,5,m);
            imagesc(te(:,:,m));
        end
    else
        te = reshape(data,[13,13,10]);
        imagesc(te(:,:,l));
    end
end
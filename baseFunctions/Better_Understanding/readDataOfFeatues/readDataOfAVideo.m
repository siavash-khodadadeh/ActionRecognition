clear;
clc;
videoClass = 6;
videoNumber = 15;
[dataSet, pointValues, timeData] = loadDataOfAVideo(videoClass, videoNumber);
while 1==1
    clc;
    fprintf('Number of features is equal to: %d\n',size(dataSet,1));
    k = input('Select the number of feature which you want to see: ');
    if k == -1
        display('finished');
        break;
    end
    varianceOfFeature = calculateFitnessOfTheFeature(dataSet(k,:));
    varianceOfFeature = round(varianceOfFeature);
    display(varianceOfFeature);
    l = input('Select the number of frame you want to see or type 0 to show all: ');
    if l == 0
        te = reshape(dataSet(k,:),[13,13,10]);
        te = uint8(te);
        for m = 1:10
            subplot(2,5,m);
            imshow(te(:,:,m));
        end
    else
        te = reshape(dataSet(k,:),[13,13,10]);
        te = uint8(te);
        imshow(te(:,:,l));
    end
end
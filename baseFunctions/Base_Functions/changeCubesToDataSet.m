function [dataSet] = changeCubesToDataSet(interestedCubes,width,height,depth)
    l = length(interestedCubes);
    dataSet = zeros(l,width*height*depth);
    for i = 1:l
        temp = interestedCubes{i};
        dataSet(i,:) = reshape(temp,[1 width*height*depth]);
    end
end
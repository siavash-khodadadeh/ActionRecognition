function [flattenedGradientData] = getFlattendGradientData(data,r,c,d)
    [row col] = size(data);
    flattenedGradientData = zeros(row,col);
    for i = 1:row
        simpleCube = reshape(data(i,:),[r,c,d]);
        sobel(:,:,1) = [1 2 1;2 4 2;1 2 1];
        sobel(:,:,3) = -[1 2 1;2 4 2;1 2 1];
        flattenedGradientDataCube = convn(simpleCube,sobel,'same');
    
        flattenedGradientData(i,:) = reshape(flattenedGradientDataCube,[1,r*c*d]);
    end
end

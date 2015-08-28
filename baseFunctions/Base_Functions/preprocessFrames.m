function [result,w,h] = preprocessFrames(mov,numberOfFrames,shouldResize)
    [height, width colors] = size(mov);
    for i = 1:numberOfFrames
%         [grayLevelImg] = convertImgToGrayLevel(mov(i).cdata);
        [grayLevelImg] = convertImgToGrayLevel(mov);
        if shouldResize == 1
            w = width / 4;
            h = height / 4;
            grayLevelImg = imresize(grayLevelImg,[h,w],'bilinear');
        else
            w = width;
            h = height;
        end
        result = zeros(h,w,numberOfFrames,'uint8');
        result(:,:,i) = grayLevelImg;
    end
end
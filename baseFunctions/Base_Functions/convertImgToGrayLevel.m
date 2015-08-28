function [result] = converImgToGrayLevel(img)
    % convertImageToGrayLevel ycbcr
    result = (double(img(:,:,1))+double(img(:,:,2))+double(img(:,:,3)))/3;
    result = uint8(result);
end
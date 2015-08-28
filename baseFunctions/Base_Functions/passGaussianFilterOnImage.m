function [result] = passGaussianFilterOnImage(img,x,y,sigma)
    gauss = fspecial('gaussian',[x y],sigma);
    result = conv2(double(img),gauss,'same');
end
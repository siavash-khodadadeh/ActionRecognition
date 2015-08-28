function [selectedFrames,numberOfFrames] = selectFrames(obj)
%     preparedMov = zeros(obj.height,obj.width,obj.numberOfFrames);
%     height = obj.height/4;
%     width = obj.width/4;
% using pca in time
    n = obj.NumberOfFrames;
    diff = min(ceil(n/17),150);
    selectedFrames = [1:diff:n];
    numberOfFrames = length(selectedFrames);
end
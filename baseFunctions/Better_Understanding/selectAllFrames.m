function [selectedFrames,numberOfFrames] = selectAllFrames(obj)
%     preparedMov = zeros(obj.height,obj.width,obj.numberOfFrames);
%     height = obj.height/4;
%     width = obj.width/4;
% using pca in time
    n = obj.NumberOfFrames;
    diff = 1;
    selectedFrames = [1:diff:n];
    numberOfFrames = length(selectedFrames);
end
function [word] = findWord(data,clusters)
%     word = floor(1000 * rand(1));
    valuesOfDistance = dist([data',clusters']);
    valuesOfDistance = valuesOfDistance(1,2:size(clusters,1)+1);
    [minValue,word] = min(valuesOfDistance);
end
function [word] = findWord(data, clusters)
    valuesOfDistance = dist([data', clusters']);
    valuesOfDistance = valuesOfDistance(1, 2:size(clusters, 1) + 1);
    [minValue, word] = min(valuesOfDistance);
end

clear;
clc;
clusterDataAddress = '../data/all_folds/fold1.clusters';
pcaCoeffAddress = '../data/all_folds/fold1.pcaCoeffData';
videoBaseAddress = '../data/dataset/';
videoClasses = {'boxing', 'handclapping', 'handwaving', 'jogging', 'running', 'walking'};
clusterData = importdata(clusterDataAddress);
pcaCoeff = importdata(pcaCoeffAddress);
delete(gcp('nocreate'));
matlabpool open 16;
for k = 1:length(videoClasses)
    allFiles = dir(strcat(videoBaseAddress, videoClasses{k}, '/'));
    allFiles(1:2) = [];
    parfor w = 1:size(allFiles, 1)
%         fprintf('filename is %s\n', allFiles(w).name);
	[fid, err] = fopen(strcat('../data/word2vec_data/', videoClasses{k}, '/',allFiles(w).name));
	if isempty(err)
		fclose(fid);
		continue;
	end
        videoAddress = allFiles(w).name;
        videoData = importdata(strcat(videoBaseAddress, videoClasses{k}, '/', videoAddress));
        videoDataPca = double(videoData(:, 2:1691)) * pcaCoeff;
        videoDataPca = videoDataPca(:, 1:100);
        videoTimeData = zeros(size(videoData, 1), 2);
        for i = 1:size(videoData, 1)
            wordData = videoDataPca(i, :);
            wordNumber = findWord(wordData, clusterData);
            videoTimeData(i, :) = [wordNumber, videoData(i, 1694)];
            if rem(i, 10) == 0
                fprintf('video %s: %0.2f percent completed.\n', allFiles(w).name, i / size(videoData, 1) * 100)
            end
        end
        videoTimeData = sortrows(videoTimeData, 2);
        basicSave(strcat('../data/word2vec_data/', videoClasses{k}, '/',allFiles(w).name), videoTimeData, true)
    end
end
delete(gcp('nocreate'));


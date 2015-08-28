function [semanticTraining,semanticTest] =createDiffusionModel(data,testData,numberOfSemanticWords,markovOrder,sigma)
%     baseFeatureDataSetAddress = '/media/siavash/01D00557EB1240C0/Matlab Workspace/MasterThesis/HumanActionRecognition/data/';
%     baseLabelAddress ='/media/siavash/01D00557EB1240C0/Master Thesis/midasDatabase/videos/Public Projects/VIRAT/Public Dataset/VIRAT Video Dataset Release 2.0/VIRAT Ground Dataset/docs/README_annotations_evaluations.xls';
%     sigma = 1;
%     markovOrder = 1;
%     data = importdata(strcat(baseFeatureDataSetAddress,'finalData.data'));
    [r c] = size(data);
%     evaluationData = xlsread(baseLabelAddress);
%     evaluationData = evaluationData(1:329,9:20);
%     evaluationData([3,8,26],:) = [];
%     labels = (evaluationData(:,9)>0);
    normalizedRows = normr(data);
    rows = size(normalizedRows,1);
    n = 1 ./ sqrt(sum(normalizedRows.*normalizedRows,1));
    yi = normalizedRows .* n(ones(1,rows),:);
    yi(~isfinite(yi)) = 1;
    normalizedData = yi;
    
    normalizedTestRows = normr(testData);
    rows = size(normalizedTestRows,1);
%     n = 1 ./ sqrt(sum(normalizedTestRows.*normalizedTestRows,1));
    yi = normalizedTestRows .* n(ones(1,rows),:);
    yi(~isfinite(yi)) = 1;
    normalizedTestData = yi;
    
    
%     normalizedData = normc(normalizedRows);
    pmi = zeros(r,c);
    for i = 1:r
        for j = 1:c
%             if normalizedData(i,j) ~= 0
%                 pmi(i,j) = log2(normalizedData(i,j)/(sum(normalizedData(i,:))*sum(normalizedData(:,j))));
%             else
%                 pmi(i,j) = -10000;
%             end
            pmi(i,j) = normalizedData(i,j)/(sum(normalizedData(i,:))*sum(normalizedData(:,j)));
        end
    end
    w = zeros(c,c);
    for i = 1:c
        for j = 1:c
            if i <= j
                distance = sum((pmi(:,i) - pmi(:,j)).^2);
    %             distMatrix = dist([pmi(:,i),pmi(:,j)]);
                w(i,j) = exp(-(distance)/(2*sigma));
              else
                w(i,j) = w(j,i);
            end
        end
    end

    p1 = zeros(c,c);
    for i = 1:c
        for j = 1:c
            p1(i,j) = w(i,j) / sum(w(i,:));
        end
    end

    pMarkovOrder = p1^markovOrder;
    [eigenVectors,eigenValuesMatrix] = eig(pMarkovOrder);
    [tempEigVectors] = eig(pMarkovOrder);
    [sortedValues,sortedIndices] = sort(tempEigVectors,'descend');
    vectorsIndices = sortedIndices(2:101)';
    diffusionMap = zeros(100,c);
    
    for j = 1:1000
        counter = 1;
        for i = vectorsIndices
    %     for i = 1:1000
%             diffusionMap(i,j) = eigenValuesMatrix(i,i)*((sum(pMarkovOrder(:,j).*eigenVectors(:,i))/sum(eigenVectors(:,i).^2))*eigenVectors(:,i));
             diffusionMap(counter,j) = eigenValuesMatrix(i,i)*((sum(pMarkovOrder(:,j).*eigenVectors(:,i))/sum(eigenVectors(:,i).^2)));
             counter = counter + 1;
        end
    end
    tempDiffusionData = diffusionMap';
%     numberOfSemanticWords = 20;
    [idx,clusters] = kmeans(tempDiffusionData,numberOfSemanticWords,'distance','sqEuclidean');

    semanticTraining = zeros(size(data,1),numberOfSemanticWords);
    for i = 1:size(data,1)
        for j = 1:1000
            semanticTraining(i,idx(j)) = semanticTraining(i,idx(j))+data(i,j);
        end
    end
    semanticTest = zeros(size(testData,1),numberOfSemanticWords);
    for i = 1:size(testData,1)
        for j = 1:1000
            semanticTest(i,idx(j)) = semanticTest(i,idx(j))+testData(i,j);
        end
    end
    
    % acc = zeros(1,10);
    % eCN = ceil(r/10);
    % for i = 1:10
    %     cluster = (i-1)*eCN+1:min(i*eCN,r);
    % %     test = data(cluster,:);
    %     test = p1(cluster,:);
    %     testLabels = labels(cluster);
    % %     train = data(~ismember(1:r,cluster),:);
    %     train = p1(~ismember(1:r,cluster),:);
    %     trainLabels = labels(~ismember(1:r,cluster));
    %     guessLabels = knnclassify(test,train,trainLabels,3);
    %     acc(i) = sum(guessLabels == testLabels)/length(cluster);
    % end
    % accuracy = mean(acc);

end
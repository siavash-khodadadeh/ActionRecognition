function recommendLabels = runSvmOnData(trainClasses,semanticTraining,semanticTest)
    c = [];
    for k = 1:6
        for j = k+1:6
            a = find(trainClasses == k);
            b = find(trainClasses == j);
            runTimeError = 1;
            while runTimeError == 1
                try
                    svmLearner = svmtrain(semanticTraining([a;b],:),[ones(length(a),1);zeros(length(b),1)],'method','LS','kernel_function','rbf','rbf_sigma',50);
                    runTimeError = 0;
                catch
                    fprintf('--------------------------------------------\n----SVM could not converge--trying again----\n--------------------------------------------\n');
                end
            end
            c = [c,svmclassify(svmLearner,semanticTest)];
        end
    end
    recommendLabels = [];
    for l = 1:size(semanticTest,1)
        rowVec = c(l,:);
        counter = 1;
        eachClassVotes = zeros(1,6);
        for j =1:6
            for k = j+1:6
                if rowVec(counter) == 1
                    eachClassVotes(j) = eachClassVotes(j) + 1;
                else
                    eachClassVotes(k) = eachClassVotes(k) + 1;
                end
                counter = counter + 1;
            end
        end
        [val, index] = max(eachClassVotes);
        recommendLabels = [recommendLabels;index];
    end
end
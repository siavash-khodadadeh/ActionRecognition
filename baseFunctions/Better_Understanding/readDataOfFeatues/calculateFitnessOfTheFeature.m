function fitness = calculateFitnessOfTheFeature(inputFeature)
    videoFeature = reshape(inputFeature,[13,13,10]);
    mainFrame = videoFeature(:,:,5);
    distanceFromTheMainFrame = zeros(1,10);
    for i = 1:10
        distanceFromTheMainFrame(i) = (sum(sum((videoFeature(:,:,i)-mainFrame).^2)))./169;
    end
    fitness = mean(distanceFromTheMainFrame);
end
function [dataSet, pointValues, timeData] = loadDataOfAVideo(videoClass, videoNumber)
    class_boxing = 'boxing';
    class_handclpping = 'handclapping';
    class_handwaving = 'handwaving';
    class_jogging = 'jogging';
    class_running = 'running';
    class_walking = 'walking';
    classes = {class_boxing, class_handclpping, class_handwaving, class_jogging, class_running, class_walking};
    dataSet = importdata(strcat('../../../data/kthdata/', classes{videoClass}, '/', classes{videoClass}, '_', num2str(videoNumber), '.table'));
    pointValues = importdata(strcat('../../../data/kthdata/', classes{videoClass}, '/', classes{videoClass}, '_', num2str(videoNumber), '.timedata'));
    timeData = importdata(strcat('../../../data/kthdata/', classes{videoClass}, '/', classes{videoClass}, '_', num2str(videoNumber), '.pointvalues'));
end
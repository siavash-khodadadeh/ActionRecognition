function distOfVideos = calculateDistanceOf2Videos(vid1Address, vid2Address)
    vid1 = importdata(vid1Address);
    vid2 = importdata(vid2Address);
    allWordsData = importdata('../../../data/word2vec_data/allWordsVectors.txt');
    distanceData = dist(allWordsData);
    distOfVideos = 0;
    for i = 1:length(vid1)
        distOfVideos = distOfVideos + distanceData(vid1(i), vid2(i));
    end
end
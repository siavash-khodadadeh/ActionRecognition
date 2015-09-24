function graphData()
    a = importdata('../../data/all_folds/25-folds-correct/fold1.trainData');
%     b = maxFilterFunction(a);
    b = maxFilterConv2(a, 1);
    imagesc(b)
end
function b = maxFilterFunction(a)
%     b = a
    for i = 2:size(a, 1) - 1
        for j = 2:size(a,2) - 1
          if max(a(i-1:i+1, j-1:j+1)) > a(i, j)
              b(i, j) = 0;
          end
        end
    end
end
function b = maxFilterConv2(a, numberOfRepeats)
    b = a;
    for i = 1:numberOfRepeats
        b = conv2(b, [-1, -1, -1;-1, 9, -1;-1, -1, -1]);
        b(b < 0) = 0;
    end
end
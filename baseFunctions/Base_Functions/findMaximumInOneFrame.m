function [points,pointsValues] = findMaximumInOneFrame(inputMatrix,width,height,depth,frameNumber,threshold)
%  put a debug here and imagesc(inputMatrix(:,:,1))
%  then imagesc(inputMatrix(:,:,2)) and imagesc(inputMatrix(:,:,3))
    points = [];
    pointsValues = [];
    te = inputMatrix - min(min(min(inputMatrix)));
    te = te ./ max(max(max(te)));
    [r, c, d] = size(inputMatrix);
    finalMatrix = zeros(r,c,d);
    for i = 1:r
%         fprintf('%d\n',i)
        for j = 1:c
            for k = frameNumber
%                 if inputMatrix(i,j,k) > threshold
                  if te(i,j,k) > threshold
                    tempArea = inputMatrix(max(1,i-floor(width/2)):min(i+floor(width/2),r),max(1,j-floor(height/2)):min(j+floor(height/2),c),max(1,k-floor(depth/2)):min(d,k+floor(depth/2)));
                    if inputMatrix(i,j,k) == max(max(max(tempArea)))
                        finalMatrix(i,j,k) = 1;
                        points = [points;i,j,k];
                        pointsValues = [pointsValues,inputMatrix(i,j,k)];
                    end
                end
            end
        end
    end
end
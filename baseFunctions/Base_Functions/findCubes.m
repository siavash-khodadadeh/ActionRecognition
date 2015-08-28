function [cubes] = findCubes(finalResult,interestedPoints,width,height,depth)
    wAdd = floor(width/2);
    hAdd = floor(height/2);
    dAdd = floor(depth/2);
    [r, c, d] = size(finalResult);
    [x y] = size(interestedPoints);
    cubes = cell(1,x);
%     originalPoints = cell(1,x);
    for i = 1:x
        [p] = interestedPoints(i,:);
%         temp = finalResult(max(p(1)-wAdd,1):min(p(1)+wAdd,r),max(p(2)-hAdd,1):min(p(2)+hAdd,c),max(p(3)-dAdd,1):min(p(3)+dAdd,d));
        temp = finalResult(max(p(1)-wAdd,1):min(p(1)+wAdd,r),max(p(2)-hAdd,1):min(p(2)+hAdd,c),:);
%         originalData = originalDataInput(max(p(1)-wAdd,1):min(p(1)+wAdd,r),max(p(2)-hAdd,1):min(p(2)+hAdd,c),max(p(3)-dAdd,1):min(p(3)+dAdd,d));
        [row, col, dep] = size(temp);
        cube =temp;
        if ~(row == width)
            shouldBeAddedZero = width - row;
            if rem(shouldBeAddedZero,2) == 0
                cube = padarray(cube,[(shouldBeAddedZero/2) 0 0]);
            else
                cube = padarray(cube,[((shouldBeAddedZero+1)/2) 0 0]);
                cube = cube(1:width,:,:);
            end
        end
        
        if ~(col == height)
            shouldBeAddedZero = height - col;
            if rem(shouldBeAddedZero,2) == 0
                cube = padarray(cube,[0 (shouldBeAddedZero/2) 0]);
            else
                cube = padarray(cube,[0 ((shouldBeAddedZero+1)/2) 0]);
                cube = cube(:,1:height,:);
            end
        end
        
%          if ~(dep == depth)
%             shouldBeAddedZero = depth - dep;
%             if rem(shouldBeAddedZero,2) == 0
%                 cube = padarray(cube,[0 0 (shouldBeAddedZero/2)]);
%             else
%                 cube = padarray(cube,[0 0 ((shouldBeAddedZero+1)/2)]);
%                 cube = cube(:,:,1:depth);
%             end
%         end
        if size(cube,1)~= 13 || size(cube,2) ~=13 || size(cube,3)~=10
            fprintf('wrong cube');
        end
        cubes{i} = cube;
%         originalPoints{i} = originalData;
    end
end
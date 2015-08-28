function [gaborFilterEV,gaborFilterOD] = gaborFilter(x1,x2,omega,taw)
    gaborFilterEV = zeros(1,x2 - x1 + 1);
    gaborFilterOD = zeros(1,x2 - x1 + 1);
    for i = x1:x2
        gaborFilterEV(i-x1+1) = simpleGaborEV(i,omega,taw);
        gaborFilterOD(i-x1+1) = simpleGaborOD(i,omega,taw);
    end
end
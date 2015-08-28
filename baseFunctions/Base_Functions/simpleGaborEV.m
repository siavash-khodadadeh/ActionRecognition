function [y] = simpleGaborEV(t,omega,taw)
    y = - cos(2*pi*omega*t)* exp(-((t^2)/(taw^2)));
end
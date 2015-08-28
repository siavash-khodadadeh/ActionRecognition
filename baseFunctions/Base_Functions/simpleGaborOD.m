function [y] = simpleGaborOD(t,omega,taw)
    y = - sin(2*pi*omega*t)* exp(-((t^2)/(taw^2)));
end
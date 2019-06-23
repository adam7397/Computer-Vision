clc;
clear all;
close all;

radius_center = 1000;

h = 1000;

radius_galaxy = 100000;

s = 1*exp(-25);

G = 6.67 * exp(-11);

r = 0.01;

dr = 0.01;

i =1;

while(r<radius_galaxy)
    if(r < radius_center)
        Menc = s*pi*r^2*h;  
    else
        Menc = s*pi*radius_center^2*h;
    end
    menD = s/(1+(r/radius_center))^2*(4/3)*pi*r^3;
    v = sqrt((G*Menc)/r);

    radius = r;

    r = r + dr;
    
    i = i+1;
end

plot(radius, v);
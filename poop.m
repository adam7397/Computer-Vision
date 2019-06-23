clc;
clear all;
close all;

matter = 0.7;
d_energy = 0.7;

curTime = 0;
curScale = 1;
curH0 = 0.75;
dt = 0.01;
i = 1;

while (curTime < 10)
    accel = -matter / (2*curScale^2) + d_energy*curScale;
    curH0 = curH0 + dt * accel;
    curScale = curScale + dt * curH0;
    curTime = curTime + dt;
    time(i) = curTime;
    scale(i) = curScale;
    i = i + 1;
end

plot(time, scale)
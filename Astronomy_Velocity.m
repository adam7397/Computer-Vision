clc;
close all;
clear all;

%Define constants
G = 6.67e-11 %messes up units
Ms = 1.98e30; %kg
Me = 5.97e24; %kg
Re = 1.5 %AU
AU2m = 1.496e11; % meters in an AU

%Define initial position
r = [0,0,0;Re*AU2m,0,0];

%Define our initial velocities
%v = [0,0,0;,0,sqrt(G*Ms/(AU2m*Re)),0];
v = [0,0,0;0,sqrt(G*Ms*(2/(AU2m*Re)-(1/(AU2m*Re)))),0];

M = [Ms, Me];

%Define the number of iterations
Nsteps = 1000;
dt = 1e5;
t = 0;

for i = 1:Nsteps
    for j = 1:2
        for k = 1:2
            if isequal(j,k) == 0
                Fg = gravitational_force(r(j,:),r(k,:),M(j),M(k));
                v(j,:) = v(j,:) + (Fg/M(j))*dt;
                
                r(j,:) =  r(j,:) +  v(j,:)*dt;
            end
        end
    end
    plot3(r(:,1)/AU2m,r(:,2)/AU2m,r(:,3)/AU2m,'o')
    axis([-3 3 -3 3 -3 3])
    title(num2str(t/60/60/24/365.25))
    drawnow;
    t = t + dt;
end

function [ Fg ] = gravitational_force(rs, re, ms, me)
    G = 6.67e-11;
    r = norm(rs-re);
    %r = sqrt(re(1)^2+re(2)^2+re(3)^2);
    Fg = -(G*ms*me/r^2)*((rs-re)/r);
end
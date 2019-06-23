clc;
clear all;
close all;

I = imread('peppers.png');
[m,n,z] = size(I);
imshow(I);

I_gray = rgb2gray(I);figure;imshow(I_gray);
I_double = im2double(I_gray);
I_lowResolution = I_gray(1:4:end,1:4,end);
figure;imshow(I_lowResolution);

Gammscaled = imadjust(I_gray, [ ], [ ], 0.5);
Scaled = (I_double - min(min(I_double)))/(max(max(I_double))-min(min(I_double)));
figure;
subplot(1,3,1); imshow(I_gray);
title('Fig. 1 original');
subplot(1,3,2); imshow(Gammscaled);
title('Fig. 2 Gamma');
subplot(1,3,3); imshow(Scaled,[]);
title('Fig. 3 Scaled');
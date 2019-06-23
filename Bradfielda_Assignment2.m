%Adam Bradfield, bradfielda@wit.edu, Assignment 2

clc;
clear all;
close all;

%Problem 1 Exercises on Image Scaling and Histogram Equalization
Food = imread('Food.jpg');
ScaledFood = imadjust(Food, [.3 .7]);
subplot(1,2,1); imshow(Food);
title('Original');
subplot(1,2,2); imshow(ScaledFood);
title('Scaled');

figure;
subplot(1,3,1); imhist(Food);
title('Food');
subplot(1,3,2); imhist(Food, 50);
title('Food 50');
subplot(1,3,3); imhist(Food, 100);
title('Food 100');

figure;
subplot(1,2,1); imhist(Food);
title('Food');
subplot(1,2,2); imhist(ScaledFood);
title('Scaled Food');

figure
EqualizedFood = histeq(Food);
subplot(1,3,1); imshow(Food);
title('Food');
subplot(1,3,2); imshow(ScaledFood);
title('Scaled Food');
subplot(1,3,3); imshow(EqualizedFood);
title('Equalized Food');

fprintf('%s\n','-----Finish Solving Problem 1-----');
pause;
clear all;
close all;

%Problem 2
Shapes = imread('Shapes.tiff');
se = strel('square', 20);
figure;
subplot(2,2,1); imshow(Shapes);
title('Original Image');
subplot(2,2,2); imshow(imopen(Shapes, se));
title('Open, square 20');
subplot(2,2,3); imshow(imclose(Shapes, se));
title('Close, square 20');
subplot(2,2,4); imshow(imopen(imclose(Shapes, se), se));
title('Close then Open, both square 20');

fprintf('%s\n','-----Finish Solving Problem 2-----');
pause;
clear all;
close all;

%Problem 3
Wirebond = imread('Wirebond.tiff');
se = strel('disk', 6);
se2 = strel('disk', 10);
se3 = strel('disk', 25);
subplot(1,4,1); imshow(Wirebond);
title('Original Image');
subplot(1,4,2); imshow(imerode(Wirebond, se2));
title('disk 10');
subplot(1,4,3); imshow(imerode(Wirebond, se));
title('disk 6');
subplot(1,4,4); imshow(imerode(Wirebond, se3));
title('disk 25');

fprintf('%s\n','-----Finish Solving Problem 3-----');
pause;
clear all;
close all;

%Problem 4
City = imread('City.jpg');
se = strel('square', 3);
A = imdilate(City, se);
B = imerode(City, se);
C = A - B;
figure;
imshow(C);
title('C = A – B');
disp('the reason it looks like this is beause we are manually running a closing morphology which smooths, fills holes, breaks, and concave parts');

fprintf('%s\n','-----Finish Solving Problem 4-----');
pause;
clear all;
close all;

%Problem 5

% 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
% 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
% 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0
% 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0
% 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
% 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
% 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
% 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
% 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
% 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
% 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0
% 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
% 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
% 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
% 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
% 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0


%Adam Bradfield, bradfielda@wit.edu, Assignment 1

clc;
clear all;
close all;

%Problem 1
A = imread('peppers.bmp');
figure;
imshow(A);
title('RGB Original Image');
%disp(A);
fprintf('%s\n','-----Finish Solving Problem 1-----');
pause;

%Problem 2
B = rgb2gray(A);
%figure;
%imshow(B);
TB = transpose(B);
figure;
subplot(1,2,1); imshow(B);
title('B');
subplot(1,2,2); imshow(TB);
title('TB');
maxb = max(B,[],'all');
minb = min(B,[],'all');
meanb = mean(B,'all');
medianb = median(B,'all');
X = ['maximum: ',num2str(maxb),' minimum: ',num2str(minb), ' mean: ',num2str(meanb),' median: ',num2str(medianb)];
disp(X);
fprintf('%s\n','-----Finish Solving Problem 2-----');
pause;

%Problem 3
C = im2double(B); %Converts to double and 0 to 1 in one line, stored in C
figure;
imshow(C);
title('Normalized Gray Scale Image');
fprintf('%s\n','-----Finish Solving Problem 3-----');
pause;

%Problem 4
D1 = imadjust(C, [ ], [ ], 0.25);
D2 = imadjust(C, [ ], [ ], 1.25);
figure;
subplot(2,1,1); imshow(D1);
title('D1: 0.25');
subplot(2,1,2); imshow(D2);
title('D2: 1.25');
fprintf('%s\n','The gamma changes helps brighten the image, the first one increaed it by .25 and the second by a factor of 1.25');
imwrite(D2,'Bradfield_D2.jpg');
figure;
imshow('Bradfield_D2.jpg');
title('Bradfield_D2.jpg');
fprintf('%s\n','-----Finish Solving Problem 4-----');
pause;

%Problem 5
bw1 = C;
bw1(C >= .3) = 1;
bw1(C < .3) = 0;
bw2 = im2bw(C, .3);
[c,r] = size(C);
didwork = true;
for i = 1:c
    for j = 1:r
        if bw1(i,j) ~= bw2(i,j)
            disp("My method did not work");
            didwork = false;
            break;
        end
    end
end
figure;
subplot(1,2,1); imshow(bw1);
title('my method');
subplot(1,2,2); imshow(bw2);
title('Matlab method');
if didwork == true
    disp('My method worked');
end
fprintf('%s\n','-----Finish Solving Problem 5-----');
pause;

%Problem 6
clear all;
close all;

%Problem 7
A = ReduceGrayScale('peppers.bmp');
figure;
imshow(A);
fprintf('%s\n','-----Finish Solving Problem 7-----');
close all;

%{ 
ReduceGrayScale.m
function [ RGS ] = ReduceGrayScale(input)
A = imread(input);
B = rgb2gray(A);
C = im2double(B);
RGS = C / 4;
end
%}

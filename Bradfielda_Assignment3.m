%Adam Bradfield, bradfielda@wit.edu, Assignment 3

clc;
clear all;
close all;

%Problem 1
Circuit = imread('Circuit.jpg');

threeCuircuit = meanFilter(Circuit, 3);
threeCircuit2 = meanFilter2(Circuit, 3);

figure;
subplot(1,3,1); imshow(Circuit);
title('Original');
subplot(1,3,2); imshow(threeCuircuit);
title('my 3x3 Mean Filter');
subplot(1,3,3); imshow(threeCircuit2);
title('matlab 3x3 Mean Filter');

compareImages(threeCuircuit, threeCircuit2); % are not showing to be the same image


fiveCuircuit = meanFilter(Circuit, 5);
fiveCircuit2 = meanFilter2(Circuit, 5);

figure;
subplot(1,3,1); imshow(Circuit);
title('Original');
subplot(1,3,2); imshow(fiveCuircuit);
title('my 5x5 Mean Filter');
subplot(1,3,3); imshow(fiveCircuit2);
title('matlab 5x5 Mean Filter');

fprintf('%s\n','-----Finish Mean Problem-----');
pause;

three_med_Circuit = medianFilter(Circuit, 3);
five_med_Circuit = medianFilter(Circuit, 5);
three_med_Circuit2 = medianfilt2(Circuit, 3);
five_med_Circuit2 = medianfilt2(Circuit,5);


figure;
subplot(1,3,1); imshow(Circuit);
title('Original');
subplot(1,3,2); imshow(three_med_Circuit);
title('my 3x3 Median Filter');
subplot(1,3,3); imshow(three_med_Circuit2);
title('matlab 3x3 Median Filter');

figure;
subplot(1,3,1); imshow(Circuit);
title('Original');
subplot(1,3,2); imshow(five_med_Circuit);
title('my 5x5 Median Filter');
subplot(1,3,3); imshow(five_med_Circuit2);
title('matlab 5x5 Median Filter');

compareImages(five_med_Circuit, five_med_Circuit2);
%if no output, they are the same
fprintf('%s\n','-----Finish Median Problem-----');
pause;

Moon = imread('Moon.jpg');
H = fspecial('laplacian',0.2);
Filtered = imfilter(Moon,H);
Scaledfilterd = imadjust(Filtered);
Enhanced = Moon - Filtered;
figure;
imshow(Moon);
title('Original Moon');
figure;
imshow(Filtered);
title('Laplacian Mask');
figure;
imshow(Scaledfilterd);
title('Scaled Filtered Image');
figure;
imshow(Enhanced);
title('Enhanced Image');
fprintf('%s\n','-----Finish Laplacian Problem-----');
pause;

clc;
clear all;
close all;


%Part 2

%Problem 1
threeFilter = [0 1/3 0; 1/3 2/3 1/3; 0 1/3 0];
disp('1x3 & 3x1 Mean Filter');
disp(threeFilter/2);
disp('Here I am adding the middle column and the middle row together to change the center point and then dividing by 2');
disp(' ');


%Problem 2
close all;

testimage = [ 4 6 8 9 10 ; 1 3 5 6 9; 2 4 6 12 12; 4 8 10 14 6];
mask = [ 1 2 3; 1 4 1; 1 3 2];

correlation = [31 56 77 95 82; 47 84 124 160 119; 51 94 137 174 116; 40 74 114 138 74]; 
convolution = [27 50 72 90 85; 33 72 110 145 150; 34 78 125 167 153; 34 68 100 132 98];

disp('Original Matrix');
disp(testimage);
disp('Mask');
disp(mask);
disp('Correlation');
disp(correlation);
disp('Convolution');
disp(convolution);

function m = megamean(i)
    h1 = fspecial('average',[1 3]);
    f1 = imfilter(i,h1);
    h2 = fspecial('average',[3 1]);
    f2 = imfilter(i,h2);
    
    imshow(f1);
    figure;
    imshow(f2);
    figure;
    
    a = f1 + f2;
    m = a / 2;
end

function m = compareImages(a,b)
    [c,r] = size(a);
    didwork = true;
    for i = 1:c
        for j = 1:r
            if a(i,j) ~= b(i,j)
                disp("My method did not work, but visually is close");
                didwork = false;
                return;
            end
        end
    end
    m = didwork;
end

function m = meanFilter(i,f)
    [x,y] = size(i);
    averaged = zeros(x,y);
    for h = 1:x-(f-1)
        for j = 1:y-(f-1)
            averaged(h+1,j+1) = mean2(i(h:h+(f-1),j:j+(f-1)));
        end
    end
    m = uint8(averaged);
end

function m = meanFilter2(i,f)
    m = filter2(fspecial('average',f),i)/255;
end

function m = medianFilter(i, f)
    [x,y] = size(i);
    i = padarray(i,[1 1],0,'both');
    averaged = zeros(x,y);
    for h = 2:x%-(f-2)
        for j = 2:y%-(f-2)
            try
                averaged(h-1,j-1) = median(i(h+(-(f-2):(f-2)),j+(-(f-2):(f-2))),'all');
            catch
                averaged(h-1,j-1) = median(i(h+(-1:1),j+(-1:1)),'all');
            end
        end
    end
    m = uint8(averaged);
end

function m = testmedianFilter(i,f)
    g = @(x) median(x(:));
    m = uint8(nlfilter(i, [f f], g));
end

function m = medianfilt2(i, f)
    m = uint8(medfilt2(i, [f f]));
end

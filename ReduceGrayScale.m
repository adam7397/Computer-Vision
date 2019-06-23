function [ RGS ] = ReduceGrayScale(input)
A = imread(input);
B = rgb2gray(A);
C = im2double(B);
RGS = C / 4;
end

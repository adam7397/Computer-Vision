A = imread('char_a.jpg');
se1 = strel('square', 5);
SquareErodeA1 = imerode(A, se1);
Boundary1 = imsubtract(A, SquareErodeA1);
SquareDilateA1 = imdilate(A, se1);
Boundary2 = imsubtract(SquareDilateA1, A);
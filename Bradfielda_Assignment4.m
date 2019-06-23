%Adam Bradfield, bradfielda@wit.edu, Assignment 4

clc;
clear all;
close all;

%Problem 1
Sample = imread('Sample.jpg');
orignalSample = Sample;

Sample = double(Sample);
Sample = fft2(Sample);
Sample = fftshift(Sample);

gauFilter = gauLow(Sample);
glowSample = Sample.*gauFilter;
glowSample = ifftshift(glowSample);
glowSample = ifft2(glowSample);

%Gaussian filter
figure;
subplot(1,3,1); imshow(orignalSample);
title('Original Sample');
subplot(1,3,2); imshow(gauFilter,[]);
title('Gaussian Filter');
subplot(1,3,3); imshow(glowSample,[]);
title('Gaussian Filtered Sample');

fprintf('%s\n','-----Finished Gaussian Problem-----');
pause;

butterFilter = butterHigh(Sample);
butterSample = Sample.*butterFilter;
butterSample = ifft2(ifftshift(butterSample));


%Buttterworth filter
figure;
subplot(1,3,1); imshow(orignalSample);
title('Original Sample');
subplot(1,3,2); imshow(butterFilter, []);
title('Butterworth Filter');
subplot(1,3,3); imshow(butterSample, []);
title('Butterworth Filtered Sample');

disp('The filters are somewhat opposites in this case. The high pass starts at the floor and works up to the objects, while the low pass starts at the top and focus on the foreground');

fprintf('%s\n','-----Finished Butterworth Problem-----');
pause;

clc;
clear all;
close all;

%Problem 2
Sample = fftshift(fft2(double(imread('Sample.jpg'))));
NewCapitol = fftshift(fft2(double(imread('NewCapitol.jpg'))));

Mag_Sample = abs(log10(Sample));
Mag_NewCapitol = abs(log10(NewCapitol));

Phase_Sample = angle(Sample);
Phase_NewCapitol = angle(NewCapitol);

%Sample = mat2gray(Sample);
%NewCapitol = mat2gray(NewCapitol);

figure;
%subplot(1,6,1); imshow(Sample,[]); title('Sample');
subplot(1,4,1); imshow(Mag_Sample,[]);
title('Mag Sample');
subplot(1,4,2); imshow(Phase_Sample, []);
title('Phase Sample');
%subplot(1,6,4); imshow(NewCapitol, []); title('NewCapitol');
subplot(1,4,3); imshow(Mag_NewCapitol, []);
title('Mag NewCapitol');
subplot(1,4,4); imshow(Phase_NewCapitol, []);
title('Phase NewCapitol');

fprintf('%s\n','-----Finished deconstruction Problem-----');
pause;

%Reconstruction

%FT Images
RESample = uint8(real(ifft2(ifftshift(Sample))));
RENewCapitol = uint8(real(ifft2(ifftshift(NewCapitol))));

%Mag Image
REMagSample = ifft2(abs(fft2(imread('Sample.jpg'))));
REMagNewCapitol = ifft2(abs(fft2(imread('NewCapitol.jpg'))));

%Phase Image
REPhaseSample = ifft2(exp(1i*Phase_Sample));
REPhaseNewCapitol = ifft2(exp(1i*Phase_NewCapitol));

figure;
subplot(1,2,1); imshow(RESample,[]); title('Sample, reconstructed');
subplot(1,2,2); imshow(RENewCapitol, []); title('NewCapitol, reconstructed');
figure
subplot(1,4,1); imshow(uint8(REMagSample)); title('REMagSample, reconstructed');
subplot(1,4,2); imshow(uint8(REMagNewCapitol)); title('REMagNewCapitol, reconstructed');
subplot(1,4,3); imshow(REPhaseSample,[]); title('REPhaseSample, reconstructed');
subplot(1,4,4); imshow(REPhaseNewCapitol, []); title('REPhaseNewCapitol, reconstructed');
disp('The reason why the images look nothing like the original is because they are both needed together to reconstruct the orginal. The phase shows more of the details and the magnitude the intensity');
fprintf('%s\n','-----Finished reconstruction Problem-----');
pause;

clc;
clear all;
close all;


%Problem 3
boy_noisy = imread('boy_noisy.gif');
FTboy_noisy = fftshift(fft2(double(boy_noisy)));
mag_boy = abs(log10(FTboy_noisy));

mag_boy(241, 225) = neighboorhood(mag_boy,241, 225);
mag_boy(273, 225) = neighboorhood(mag_boy,273, 225);
mag_boy(273, 289) = neighboorhood(mag_boy,273, 289);
mag_boy(241, 289) = neighboorhood(mag_boy,241, 289);
ph_boy = angle(FTboy_noisy);
if_boy = (10.^(mag_boy)) .* (exp(1i * ph_boy));
if_boy = ifft2(ifftshift(if_boy));


subplot(1,2,1); imshow(boy_noisy); title('original image');
%subplot(1,4,2); imshow(FTboy_noisy); title('ft image');
%subplot(1,4,3); imshow(mag_boy, []); title('mag boy');
subplot(1,2,2); imshow(uint8(if_boy), []); title('fixed boy');

disp('The reason why the 4 major values were chosen to the transformation is due to them being the concentration of the noise, averaging them out removed the noise overall');
fprintf('%s\n','-----Finished boy denoising Problem-----');
pause;
clc;
clear all;
close all;

function m = neighboorhood(image, m, n)
    n1 = image(m-1,n-1);
    n2 = image(m, n-1);
    n3 = image(m+1,n-1);
    n4 = image(m-1,n);
    n5 = image(m+1,n);
    n6 = image(m-1,n+1);
    n7 = image(m-1,n);
    n8 = image(m-1,n-1);
    m = (n1 + n2 + n3 + n4 + n5 + n6 + n7 + n8)/8;
end

function m = butterHigh(i)
    [M,N] = size(i);
    f1=-floor(M/2):floor(M/2)-1;
    f2=-floor(N/2):floor(N/2)-1;
    [fx,fy]=meshgrid(f1,f2);
    
    filter = 1./(1+((sqrt(2) - 1) * ((80 ./(sqrt(fx.^2 + fy.^2))).^(2*2))));
    m = filter;
end

function m = gauLow(i)
    sigma = 40;
    [M,N,s] = size(i);
    f1=-fix(M/2):ceil(M/2)-1;
    f2=-fix(N/2):ceil(N/2)-1;
    [fx,fy]=meshgrid(f1,f2);
    X=exp(-2*pi*pi*sigma*sigma*((fx/M).^2+(fy/N).^2));
    
    If=fft2(i);
    If=fftshift(If);
    If=If.*X;
    If=ifftshift(If);
    i=real(ifft2(If));
    m = i;
end

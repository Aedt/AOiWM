clear;
close all;

% wczytanie oryginalnego obrazu
I = imread('mandi.tif');

% pobieranie rozmiaru oryginalnego obrazu
[M, N, L] = size(I);

% wyświetlanie oryginału
figure(1) 
imshow(I);

% wypełnianie obrazu zerami
Z  = zeros(M,N,3,'uint8');
mR = zeros(M,N,3,'uint8');
mG = zeros(M,N,3,'uint8');
mB = zeros(M,N,3,'uint8');

% R G
Z(1:2:end,1:2:end,1)= I(1:2:end,1:2:end,1);
Z(1:2:end,2:2:end,2)= I(1:2:end,2:2:end,2);

% G B
Z(2:2:end,1:2:end,2)= I(2:2:end,1:2:end,2);
Z(2:2:end,2:2:end,3)= I(2:2:end,2:2:end,3);

% wyświetlanie obrazu z nałożoną mozaiką
figure(2)
imshow(Z);

R = [0.25 0.5 0.25;
     0.5  1   0.5;
     0.25 0.5 0.25];
 
B = [0.25 0.5 0.25;
     0.5  1   0.5;
     0.25 0.5 0.25];
 
G = [0    0.25 0;
     0.25 1    0.25;
     0    0.25 0];

%mR(:, :, 1)= Z(:, :, 1);
mR(: ,:, 1) = imfilter(Z(:, :, 1), R);
figure(3)
imshow(mR); 

%mG(:, : ,2)=Z(:, :, 2);
mG(:, :, 2) = imfilter(Z(:, :, 2), G);
figure(4)
imshow(mG); 

%mB(:, :, 3)=Z(:, :, 3);
mB(:, : ,3) = imfilter(Z(:, : ,3), B);
figure(5)
imshow(mB); 

% wyświetlanie zdjęcia po demozaikowaniu
figure(6)
imshow(mR + mB + mG); 

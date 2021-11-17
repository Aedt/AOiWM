clc;
clear;

% wczytanie oryginalnego obrazu
Y = imread('Lampart_noise.jpg');

% pobranie wymiarów obrazu
[W, H, O] = size(Y);

% kształty filtrów
totem = @(x) (abs(x) < 1/2);
tipi  = @(x) (abs(x) < 1) .* (1 - abs(x));

FXY = totem(linspace(-1, 1, 5)' * linspace(-1, 1, 5));
% FXY = tipi(linspace(-1, 1, 5)' * linspace(-1, 1, 5));

FXX = FXY/sum(FXY(:));
A = sum(FXY(:));
Z = imfilter(Y, FXX,'replicate');

% wyświetlanie oryginalnego obrazu
figure(1)
imshow(Y);

% wyświetlanie obrazu po filtracji
figure(2)
imshow(Z);

imwrite(Z, 'Lampart_po_filtracji.jpg')

A = imread('Lampart_po_filtracji.jpg');
B = imresize(imread('Lampart.jpg'), [1024 1024]);

err = immse(A, B);
disp(err);

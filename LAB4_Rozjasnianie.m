clear;
close all;

% wczytanie oryginalnego obrazu
in_img = uint8(imread('dziabong.jpg'));

% pobieranie rozmiaru oryginalnego obrazu
[height, width, c] = size(in_img);

% wypełnianie obrazu wyjściowego zerami
out_img = uint8(zeros(height, width, c));

for z = 1:c
    for h = 1:height
        for w = 1:width
            x = in_img(h, w, z); 

            k = 1;
            usave = 1;
            usave = usave * rand;
                while usave >= exp(-double(x))
                    usave = usave * rand;
                    k = k + 1;
                end     
                
            % lambda = lambda/x
            lambda = k/2;
            
            out_img(h, w, z) = lambda;
        end
    end
end

figure(5)
imshow(out_img);

% zamiana obrazu na czarno-biały
out_grey_img = rgb2gray(out_img);
 
% Canny method
Canny_method = edge(out_img(:,:,1),'Canny');

% Prewitt method
Prewitt_method = edge(out_img(:,:,1),'Prewitt');

% Sobel method
[~,threshold] = edge(out_img(:,:,1),'Sobel');
fudgeFactor = 0.5;
Sobel_method = edge(out_img(:,:,1),'Sobel',threshold * fudgeFactor);

figure(1)
imshow(Canny_method);
title('Canny')

figure(2)
imshow(Prewitt_method);
title('Prewitt')

figure(3)
imshow(Sobel_method);
title('Sobel')
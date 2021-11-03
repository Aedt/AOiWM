clear;
close all;

img = imread('mandi.tif');

figure,imshow(img);
[height, width, x] = size(img);
bayer = uint8(zeros(height,width));

for numRows = 1:height
    for numCols = 1:width
        if((1 == mod(numRows,2)) && (1 == mod(numCols,2)))
            bayer(numRows,numCols) = img(numRows,numCols,3);
        elseif((0 == mod(numRows,2)) && (0 == mod(numCols,2)))
            bayer(numRows,numCols) = img(numRows,numCols,1);
        else
            bayer(numRows,numCols) = img(numRows,numCols,2);
        end
    end
end

figure,imshow(bayer);

bayerBackground = zeros(height+2,width+2);
bayerBackground(2:height+1,2:width+1) = bayer;

bayerBackground(1,:) = bayerBackground(3,:);
bayerBackground(:,1) = bayerBackground(:,3);

bayerBackground(height+2,:) = bayerBackground(height,:);
bayerBackground(:,width+2) = bayerBackground(:,width);

Demosaic = zeros(height+2, width+2, x);
DemosaicBlue = zeros(height+2, width+2, x);
DemosaicRed = zeros(height+2, width+2, x);
DemosaicGreen = zeros(height+2, width+2, x);

% demozaikowanie na niebieski
for numRows = 2:height+1
    for numCols = 2:width+1
        if(1 == mod(numRows-1,2))
            if(1 == mod(numCols-1,2))
                DemosaicBlue(numRows,numCols,3) = bayerBackground(numRows,numCols);
            else
                DemosaicBlue(numRows,numCols,3) = (bayerBackground(numRows,numCols-1) + bayerBackground(numRows,numCols+1)) / 2;
            end
        else
            if(1 == mod(numCols-1,2))
                DemosaicBlue(numRows,numCols,3) = (bayerBackground(numRows-1,numCols) + bayerBackground(numRows+1,numCols)) / 2;
            else
                DemosaicBlue(numRows,numCols,3) = (bayerBackground(numRows-1,numCols-1) + bayerBackground(numRows-1,numCols+1) + bayerBackground(numRows+1,numCols-1) + bayerBackground(numRows+1,numCols+1)) / 4;
            end
        end
    end
end

DemosaicBlue = uint8(DemosaicBlue(2:height+1,2:width+1,:));
figure,imshow(DemosaicBlue);

% demozaikowanie na czerwony
for numRows = 2:height+1
    for numCols = 2:width+1
        if(1 == mod(numRows-1,2))
            if(1 == mod(numCols-1,2))
                DemosaicRed(numRows,numCols,1) = (bayerBackground(numRows-1,numCols-1) + bayerBackground(numRows-1,numCols+1) + bayerBackground(numRows+1,numCols-1) + bayerBackground(numRows+1,numCols+1)) / 4;
            else
                DemosaicRed(numRows,numCols,1) = (bayerBackground(numRows-1,numCols) + bayerBackground(numRows+1,numCols)) / 2;
            end
        else
            if(1 == mod(numCols-1,2))
                DemosaicRed(numRows,numCols,1) = (bayerBackground(numRows,numCols-1) + bayerBackground(numRows,numCols+1)) / 2;
            else
                DemosaicRed(numRows,numCols,1) = bayerBackground(numRows,numCols);
            end
        end
    end
end

DemosaicRed = uint8(DemosaicRed(2:height+1,2:width+1,:));
figure,imshow(DemosaicRed);

% demozaikowanie na zielony
for numRows = 2:height+1
    for numCols = 2:width+1
        if(1 == mod(numRows-1,2))
           if(1 == mod(numCols-1,2))
                DemosaicGreen(numRows,numCols,2) = (bayerBackground(numRows-1,numCols) + bayerBackground(numRows,numCols-1) + bayerBackground(numRows,numCols+1) + bayerBackground(numRows+1,numCols)) / 4;
            else
                DemosaicGreen(numRows,numCols,2) = bayerBackground(numRows,numCols);
            end
        else
            if(1 == mod(numCols-1,2))
                DemosaicGreen(numRows,numCols,2) = bayerBackground(numRows,numCols);
            else
                DemosaicGreen(numRows,numCols,2) = (bayerBackground(numRows-1,numCols) + bayerBackground(numRows,numCols-1) + bayerBackground(numRows,numCols+1) + bayerBackground(numRows+1,numCols)) / 4;
            end
        end
    end
end

DemosaicGreen = uint8(DemosaicGreen(2:height+1,2:width+1,:));
figure,imshow(DemosaicGreen);

for numRows = 2:height+1
    for numCols = 2:width+1
        % kiedy numRows jest parzysty = false
        if(1 == mod(numRows-1,2))
            % kiedy numCols jest parzysty = false
            if(1 == mod(numCols-1,2))
                Demosaic(numRows,numCols,3) = bayerBackground(numRows,numCols);
                Demosaic(numRows,numCols,1) = (bayerBackground(numRows-1,numCols-1) + bayerBackground(numRows-1,numCols+1) + bayerBackground(numRows+1,numCols-1) + bayerBackground(numRows+1,numCols+1)) / 4;
                Demosaic(numRows,numCols,2) = (bayerBackground(numRows-1,numCols) + bayerBackground(numRows,numCols-1) + bayerBackground(numRows,numCols+1) + bayerBackground(numRows+1,numCols)) / 4;
            else
                Demosaic(numRows,numCols,2) = bayerBackground(numRows,numCols);
                Demosaic(numRows,numCols,1) = (bayerBackground(numRows-1,numCols) + bayerBackground(numRows+1,numCols)) / 2;
                Demosaic(numRows,numCols,3) = (bayerBackground(numRows,numCols-1) + bayerBackground(numRows,numCols+1)) / 2;
            end
        else
            if(1 == mod(numCols-1,2))
                Demosaic(numRows,numCols,2) = bayerBackground(numRows,numCols);
                Demosaic(numRows,numCols,1) = (bayerBackground(numRows,numCols-1) + bayerBackground(numRows,numCols+1)) / 2;
                Demosaic(numRows,numCols,3) = (bayerBackground(numRows-1,numCols) + bayerBackground(numRows+1,numCols)) / 2;
            else
                Demosaic(numRows,numCols,1) = bayerBackground(numRows,numCols);
                Demosaic(numRows,numCols,2) = (bayerBackground(numRows-1,numCols) + bayerBackground(numRows,numCols-1) + bayerBackground(numRows,numCols+1) + bayerBackground(numRows+1,numCols)) / 4;
                Demosaic(numRows,numCols,3) = (bayerBackground(numRows-1,numCols-1) + bayerBackground(numRows-1,numCols+1) + bayerBackground(numRows+1,numCols-1) + bayerBackground(numRows+1,numCols+1)) / 4;
            end
        end
    end
end

Demosaic = uint8(Demosaic(2:height+1,2:width+1,:));
figure,imshow(Demosaic);

% Run u = InpaintByAdaptiveEulerElastica(Iin, mask, tolerance)
% By default, tolerance = 1E-10
% And mask is a binary image (black/white), but in a uint8 form (0 and 255), not a logical form. 
% If mask is a logical image, you just convert it to uint8: mask = uint8(255*mask_in_logical_form)
%#################################################################
clc; close all; clearvars;

Iin = imread('corrupted\mask1_300091.png');
mask = imread('mask\mask1.png');
groundtruth = imread('dataset\300091.jpg');
% --- Check compatible data type of mask
if(isa(mask,'uint16'))
    disp('ERROR: A mask should be logical or uint8!');
    return;
end
if(isa(mask,'uint8'))
    if(~isempty(find(mask(:)~=0 & mask(:)~=255, 1)))
      disp('ERROR: A mask must be contain 0 and 255 only!'); 
      return;
    end
end
if(islogical(mask))
    mask = uint8(255*mask);
end
% --- End of checking compatibility
disp('Running... It may take a while!');
u = InpaintByAdaptiveEulerElastica(Iin, mask, 1E-15);
clc;
u = im2uint8(u);
psnr(u, groundtruth)
ssim(u, groundtruth)
% imwrite(u, 'result\mask1_300091.png');
imshow(u);
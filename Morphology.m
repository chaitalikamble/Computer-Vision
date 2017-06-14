% Description   :   The aim of this project is to detect the STOP sign on
%                   street.
% Date Completed:   2 May 2017
% Author:           Chaitali Kamble
function im_dilate = Morphology(im)
% This function performs morphological operations and removes noise pixels
    Struct_ele  = strel('disk', 9);  % Create Structuring element
    im_dilate    = imdilate(im, Struct_ele); % Dilate the image
end
% Description   :   The aim of this project is to detect the STOP sign on
%                   street.
% Date Completed:   2 May 2017
% Author:           Chaitali Kamble
function [Red_like, Edges] = GetFeatures(im_filtered)
% This function extracts the edges and red like object from the image.
    
% Convert the image to RGB color channel
    im_lab          = rgb2lab(im_filtered);
    l               = im_lab(:,:,1);
    a               = im_lab(:,:,2);
    b               = im_lab(:,:,3);
    
    % Extract the red like object
    Red_like    = ( a < 80 ) & ( a > 40 ) ...
     & ( b > 25 ) & ( b < 55 );
    % Get the edges using canny edge detector.
    Edges       = edge(im_filtered(:,:,2), 'Canny');
     
end
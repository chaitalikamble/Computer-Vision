% Description   :   The aim of this project is to detect the STOP sign on
%                   street.
% Date Completed:   2 May 2017
% Author:           Chaitali Kamble
function im_filtered = Remove_Noise(im)
% This function remves the noise from the image.
    filter_gauss = fspecial('gauss', 1,  0.4); % Create gaussian filter
    im_filtered = imfilter(im, filter_gauss, 'same', 'repl'); % Apply filter
end
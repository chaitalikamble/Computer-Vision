% Description   :   The aim of this project is to detect the STOP sign on
%                   street.
% Date Completed:   2 May 2017
% Author:           Chaitali Kamble
function ROI = GetRegionofInterest(im, x, y)
% This function helps us to find the region of interest based on the
% bounding box
       % Get the overall dimensions of the image 
       dims                  = size(im);
        
       % If bounding box lies on the left the create a region of interest
       % starting from start pixel to mid pixel of the image else the
       % region of interest lies from mid to end of the image.
       if x >= dims(1)/2
          nstart              = round(dims(1)/2);
          width               = round(dims(1) - nstart);
       else
          nstart              = 5;
          width               = round(dims(1)/2 - nstart);
       end
       
       if y >= dims(2)/2
           mstart             = round(dims(2)/2);
           height             = round(dims(2) - mstart);
       else
           mstart = 5;
           height             = round(dims(2)/2 - mstart);
       end
       
       % Return a rectangular region of interest.
       ROI                    = [nstart, mstart, width, height];      
end
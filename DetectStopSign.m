% Description   :   The aim of this project is to detect the STOP sign on
%                   street.
% Date Completed:   2 May 2017
% Author:           Chaitali Kamble
function DetectStopSign(im)
% Detect the Stop sign using explicit implementation.
    %files = dir('StopSigns/*.png');
    %filename = strcat('StopSigns/', files(20).name);
    
    % Display original image.
    figure;
    imagesc(im);
    title('ORIGINAL IMAGE');
    
    %Remove Noise from the image
    im_filtered = Remove_Noise(im);
    
    %Get colors and edges from the image
    [im_just_red, edges ]   = GetFeatures(im_filtered);
    
    % Apply Morphology to dilate the image
    im_dilate               = Morphology(im_just_red);
    
    % Clear the surrounding borders from the image
    im_border               = imclearborder(im_dilate);
    [seperation, nlabel]    = bwlabel(im_border);
    
    % Apply the region props to get the bounding box for a Stop Sign.
    Sign_Struct             = regionprops(seperation, 'Area', 'BoundingBox');
    
    
    % A loop that processes each sign seperately if any
    for idx = 1: nlabel
        if(Sign_Struct(idx).Area >= 500)
         % Get the bounding box and define a rectangle for creating a
         % template
         
         Box                       = Sign_Struct(idx).BoundingBox;
         
         Template                  = im(round(Box(2): Box(2)+Box(4)), ...
             round( Box(1): Box(1) + Box(3)), :);
         % Pass this template for Template Matching
         computed_local_corr    = Matching_with_Template(Template, im);
         
         % Get maximum of all the points where template matches.
         [num, idx]             = max(computed_local_corr(:) );
         
         % Get the coordinates of those points.
         [x, y]                 = ind2sub(size(computed_local_corr), idx);
         
         % Create a region of interest
         ROI                    = GetRegionofInterest(im, x, y);
         %RecognizeCharacters(im, ROI);
         
         % Locate the stop sign using coordinates.
         Locate_Sign(x, y, im);
        end
    end
    
    
    if nlabel == 0      % No perfect red colored found
       
       % Create a new template from the dataset.
       % Call template matching with various templates.
       files = dir('StopSigns/*.png');
       filename = strcat('StopSigns/', files(1).name);
       im_test = im2double(imread(filename));
    
       % Area for the template
       rows = 220:245;
       cols = 480:505;
       
       % Remove noise from the image if any.
       im_test = Remove_Noise(im_test);
       
       % Create a template
       Template = im_test(rows, cols, :);
       
       % Remove noise from the template
       Template = Remove_Noise(Template);
       
       % Compute local correlation
       computed_local_corr   = Matching_with_Template(Template, im);
       
       % Get the maximum value out of matched regions
       [num, idx]             = max(computed_local_corr(:) ); 
       [x, y]                 = ind2sub(size(computed_local_corr), idx);
        
       % Create a region of interest
       ROI                    = GetRegionofInterest(im, x, y);
       %RecognizeCharacters(im, ROI);
       
       % Locate the STOP sign.
       Locate_Sign(x, y, im);
        
       pause(4);
       close All;
    end
end

function Locate_Sign(x, y, im)
% This function creates a square box around the sign and displays the new
% image with a highlighted STOP sign.
    figure;
    position        =   [y-20, x-20, 30, 30];
    imshow(im);
    hold on;
    axis on;
    rectangle('Position',position, 'LineWidth', 2, 'LineStyle', '-', 'EdgeColor', 'blue' );
    hold off;
end
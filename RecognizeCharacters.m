% Description   :   The aim of this project is to detect the STOP sign on
%                   street.
% Date Completed:   2 May 2017
% Author:           Chaitali Kamble
function RecognizeCharacters(im, ROI) 
% This function performs optical character reciognition based on the region
% of interest.
    Icorrected = imtophat(im(:,:,2), strel('disk', 15));
    
    % Perform morphological operations to erode an image.
    marker = imerode(Icorrected, strel('line',10,0));
    Iclean = imreconstruct(marker, Icorrected);
    
    % Binarize image
    BW = imbinarize(Iclean);
    
    % Get the result texts after applying OCR.
    results = ocr(BW, ROI,  'TextLayout', 'Block');
    
    %Locate the STOP text in an image.
    wordBox = locateText(results, 'STOP', 'UseRegexp', true);
    
    % Get the word list that matches.
    word = regexp(results.Text, 'STOP', 'match');
    
    % if word list is not empty that means STOP text is found  out and
    % hence now insert a bounding box surrounding to that text.
    if ~isempty(word)
        Iname = insertObjectAnnotation(im,  'rectangle', wordBox, word, ...
            'LineWidth', 1, 'Color', 'yellow', 'TextColor', 'black');
        figure;
        imshow(Iname);
        title('Sign Text');
    end
    

end
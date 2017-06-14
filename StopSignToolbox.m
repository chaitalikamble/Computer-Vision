% Description   :   The aim of this project is to detect the STOP sign on
%                   street.
% Date Completed:   2 May 2017
% Authord:          Chaitali Kamble
function StopSignToolbox(TestImage)
% This function is MATLAB's built in function that uses HOG features to detect
% the STOP sign.
    
    % Load the built in datastet
    load('stopSignsAndCars.mat');
    
    % Extract the positive instances from the dataset. (STOP sign appears)
    positiveInstances = stopSignsAndCars(:,1:2);
    
    % Get the directory of positive instances.
    imDir = fullfile(matlabroot,'toolbox','vision','visiondata','stopSignImages');
    addpath(imDir);
    
    % Extract the negative instances from the dataset. (STOP sign does not appear)
    negativeFolder = fullfile(matlabroot,'toolbox','vision','visiondata',...
    'nonStopSigns');
    
    % Train classifier based on HOG features.
    trainCascadeObjectDetector('stopSignDetector.xml',positiveInstances, ...
    negativeFolder,'FalseAlarmRate',0.1,'NumCascadeStages',5);

    % Detect the objects
    detector = vision.CascadeObjectDetector('stopSignDetector.xml');

    % Create a bounding box using step function
    bbox = step(detector,TestImage);
    
    % Insert the bounding box in the image where STOP sign appears.
    detectedImg = insertObjectAnnotation(TestImage,'rectangle',bbox,'stop sign');
    
    % Show detected STOP sign.
    figure; imshow(detectedImg);
    
    % Remove folders from the search path.
    rmpath(imDir);
end
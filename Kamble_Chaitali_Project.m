% Description   :   The aim of this project is to detect the STOP sign on
%                   street.
% Date Completed:   2 May 2017
% Authord:          Chaitali Kamble
function Kamble_Chaitali_Project(fn)
% This is the main function and execution starts from here.
% It takes the file name as a input parameter on which STOP sign need to be
% find out.
    im = im2double(imread(fn));
    
    % prompt user with two choice. 
    % 'y' : Run the function using MATLAB built in Tool box
    % 'n' : Run the function using explicit implementation.
    user_decision = input('If you want check output given by toolbox, hit "Y" else hit "N" ... '); 
    
    % Evaluate Choices
    if(user_decision == 'Y' || user_decision == 'y')
        Toolbox = true;
    else
        Toolbox = false;
    end
    
    if Toolbox
        disp('Detecting stop sign using matlab in built toolbox');
        
        % Function call to built in MATLAB toolbox function.
        StopSignToolbox(im);
    else
        disp('Detecting stop sign using my technique');
        
        % Function call to my implementation.
        DetectStopSign(im);
    end   
end
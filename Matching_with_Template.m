% Description   :   The aim of this project is to detect the STOP sign on
%                   street.
% Date Completed:   2 May 2017
% Author:           Chaitali Kamble
% Author:           Prof.Kinsman
function computed_local_corr = Matching_with_Template(Template, im)
% This function performs local correlation using template matching.
FS = 18;
    img_green               = im(:,:,2);  % Green Channel
    Sign                    = Template;   % Template of Sign
    

    mean_sign               = mean( Sign(:) );  % Calculate the Mean                      % 
    Sign_fltr_wo_mean       = Sign - mean_sign; 
    
    % Create a matrix of all ones and having size as that of local avg
    % filter.
    local_avg_filter        = ones( size(Sign) ) / numel(Sign);
    
    % Compute local average response.
    local_avg_resp          = imfilter( img_green, local_avg_filter, 'same', 'repl' );
    img_wo_local_mean       = img_green - local_avg_resp;
    computed_local_corr     = imfilter( img_wo_local_mean, Sign_fltr_wo_mean, 'same', 'repl' );
    
    %{
    % Create figures.
    fig_im = figure('Position',[400 2 1024 768]);
    imagesc( im );
    axis image;
    colormap( gray(256) );
    title(' RGB INPUT IMAGE ', 'FontSize', FS );

    fig_avg = figure('Position',[300 2 1024 768]);
    imagesc( local_avg_resp );
    axis image;
    colormap( gray(256) );
    title(' LOCAL AVERAGE OF INPUT IMAGE ', 'FontSize', FS );

    fig_Sign = figure('Position',[432    23   519   345]);
    imagesc( Sign );
    axis image;
    colormap( gray(256) );
    title(' SIGN EXTRACTED FROM THE IMAGE ', 'FontSize', FS );

    fig_resp = figure('Position',[2 2 1024 768]);
    imagesc( computed_local_corr );
    colorbar;
    axis image;
    colormap( jet(256) );
    title(' FILTER RESPONSE -- The Local Correlation ', 'FontSize', FS );
    
    % Display the created figures.
    figure( fig_avg );             
    figure( fig_im );              
    figure( fig_Sign );   
    %}
end
function Template_Matching(im)
FS =18;
    files = dir('StopSigns/*.png');
    filename = strcat('StopSigns/', files(24).name);
    im = im2double(imread(filename));
    
    
    
    rows = 200:230;
    cols = 200:230;
    
    
 
    img_green = im(:,:,2);
    
    Sign                    = img_green( cols, rows );         % Green channel, face region
    
    %Sign = imresize(Sign, 0.5);
    mean_sign               = mean( Sign(:) );                      % 
    Sign_fltr_wo_mean       = Sign - mean_sign;
    
    local_avg_filter        = ones( size(Sign) ) / numel(Sign);
    

    local_avg_resp          = imfilter( img_green, local_avg_filter, 'same', 'repl' );
    img_wo_local_mean       = img_green - local_avg_resp;
    computed_local_corr     = imfilter( img_wo_local_mean, Sign_fltr_wo_mean, 'same', 'repl' );


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

    figure( fig_avg );             
    figure( fig_im );              
    figure( fig_Sign );                
end


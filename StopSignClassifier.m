function StopSignClassifier()
    training_set = dir('StopSigns/*.png');
    %testing_set = dir('NotStopSign/*.png');
    
    
    for i=1:length(training_set)
        filename = strcat('StopSigns/', training_set(i).name);
        im = im2double( imread  (filename)  )   ;
    
        im_filtered = Remove_Noise(im);
        [color, Edges] = GetFeatures(im_filtered);
        figure;
        imagesc(color);
        figure;
        imagesc(Edges);
       
    end
    
   
end


function [dets] = ScanImageOverScale(Cparams, im, min_s, max_s, step_s)
    dets = [];
   
    for scale=min_s:step_s:max_s
        scaled_im = imresize(im, scale);
        ds = ScanImageFixedSize(Cparams, scaled_im);
        
        if size(ds, 1) == 0 
            continue;
        end
        dets = [dets; (ds / scale)]; 
        
    end
end


function [dets, scs] = ScanImageFixedSize(Cparams, im)
    if size(im, 3) == 3
        im = double(rgb2gray(im)); 
        im = im / 255;
    end
   
    im_sq = im .* im; 
    ii_im = cumsum(cumsum(im, 2), 1);
    ii_im_sq = cumsum(cumsum(im_sq, 2), 1);
    
    L = 19;
    L_sq = L * L;
    
    dets = [];
    scs = [];
    for x=1:size(ii_im, 2) - L + 1
        for y=1:size(ii_im, 1) - L + 1
            mu = CalculateBoxSum(ii_im, x, y, L, L) / L_sq;
            sig_sq = (CalculateBoxSum(ii_im_sq, x, y, L, L) - L_sq * mu * mu) / (L_sq - 1);
            
            ii_im_subpatch = ii_im(y:y+L-1, x:x+L-1);
            sc = ApplyDetector2(Cparams, ii_im_subpatch(:), mu, sqrt(sig_sq), L, L);
            if (sc > Cparams.thresh)
                %disp('found a face')
                dets = [dets; [x, y, L, L]];
                scs = [scs sc];
            end
        end
    end
end


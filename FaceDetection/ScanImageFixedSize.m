function dets = ScanImageFixedSize(Cparams, im)
    if size(im, 3) == 3
        im = double(rgb2gray(im));    
    end
   
    im_sq = im .* im; 
    ii_im = cumsum(cumsum(i, 2), 1);
    ii_im_sq = cumsum(cumsum(im_sq, 2), 1);
    
    L = 19;
    L_sq = L * L;
    for x=1:size(ii_im, 2) - L + 1
        for y=1:size(ii_im, 1) - L + 1
            mu = sum(sum(ii_im(y:y+L-1, x:x+L-1))) / L_sq;
            sig = sum(sum(ii_im_sq(y:y+L-1, x:x+L-1) - L_sq * mu)) / (L_sq - 1);
            
            ii_im_sub = ii_im(y:y+L-1, x:x+L-1);
            sc = ApplyDetector2(Cparams, ii_im_sub, mu, sig);
            if (sc > Cparams.thresh)
                % save it
            end
        end
    end
end


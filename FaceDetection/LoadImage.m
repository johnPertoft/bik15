function [n_im, ii_im] = LoadImage(im_fname)
    im = double(imread(im_fname));
    mu = mean(im(:));
    sd = std(im(:));
    n_im = (im - mu) / sd;
    
    ii_im = cumsum(cumsum(n_im, 2));
end


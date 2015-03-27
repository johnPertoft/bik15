function [fs] = ExtractGridHistogram(im, ngrids, nbins)
    xs = floor(linspace(1, size(im, 2) + 1, ngrids + 1));
    ys = floor(linspace(1, size(im, 1) + 1, ngrids + 1));

    fs = [];
    for i=1:ngrids
        ii = xs(i):xs(i+1)-1;
        for j=1:ngrids
            jj = ys(j):ys(j+1)-1;
            impatch = im(jj, ii);
            imhist = hist(impatch(:), nbins);
            imhist = imhist(:) / sum(imhist);
            fs = [fs; imhist];
        end
    end
end


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
        
        if (sig_sq < 0.005)
            continue;
        end
        
        ii_im_subpatch = ii_im(y:y+L-1, x:x+L-1);
        %sc = ApplyDetector2(Cparams, ii_im_subpatch(:), mu, sqrt(sig_sq));
        %%%%%%% WARNING
        %ApplyDetector2(Cparams, ii_im, mu, sig)
        sig = sqrt(sig_sq);
        idxs = Cparams.theta(:, 1);
        thetas = Cparams.theta(:, 2);
        parities = Cparams.theta(:, 3);
        alphas = Cparams.alphas;
        fmat = Cparams.fmat(idxs, :);
        
        fs = fmat * ii_im_subpatch(:);
        
        % feature type 3 needs special attention
        ftypes = Cparams.all_ftypes(idxs, :);
        ftypeThreeIdxs = ftypes(:, 1) == 3;
        widths = ftypes(:, 4);
        heights = ftypes(:, 5);
        fs = fs + ftypeThreeIdxs .* (widths .* heights * mu);
        fs = fs / sig;
        
        sc = sum(alphas' .* ((parities .* fs < parities .* thetas) * 2 - 1));
        
        %%%%%%%
        
        if (sc > Cparams.thresh)
            dets = [dets; [x, y, L, L]];
            scs = [scs sc];
        end
    end
end
end


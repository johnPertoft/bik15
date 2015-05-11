function sc = ApplyDetector2(Cparams, ii_im, mu, sig)

idxs = Cparams.theta(:, 1);
thetas = Cparams.theta(:, 2);
parities = Cparams.theta(:, 3);
alphas = Cparams.alphas;
fmat = Cparams.fmat(idxs, :);

fs = fmat * ii_im;

% feature type 3 needs special attention
ftypes = Cparams.all_ftypes(idxs, :);
ftypeThreeIdxs = ftypes(:, 1) == 3;
widths = ftypes(:, 4);
heights = ftypes(:, 5);
fs = fs + ftypeThreeIdxs .* (widths .* heights * mu);
fs = fs / sig;

sc = sum(alphas' .* ((parities .* fs < parities .* thetas) * 2 - 1));  
end


function sc = ApplyDetector2(Cparams, ii_im, mu, sig, w, h)

idxs = Cparams.theta(:, 1);
thetas = Cparams.theta(:, 2);
parities = Cparams.theta(:, 3);
alphas = Cparams.alphas;
fmat = Cparams.fmat(idxs, :);

fs = fmat * ii_im;

% feature type 3 needs special attention
ftypes = Cparams.all_ftypes(idxs, :);
ftypeThreeIdxs = ftypes(:, 1) == 3;
fs = fs + ftypeThreeIdxs * (w * h * mu);
fs = fs / sig;

sc = sum(alphas' .* ((parities .* fs < parities .* thetas) * 2 - 1));

   
end


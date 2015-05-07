function Cparams = BoostingAlg(Tdata, T)
    % train using only a subset of the integral images
    ii_ims = Tdata.ii_ims(:, Tdata.train_inds);
    ys = Tdata.ys(:, Tdata.train_inds);
    
    % feature responses for each feature and each image
    FX = Tdata.fmat * ii_ims;
    m = sum(ys == -1);
    n = size(ys, 2);
 
    Cparams.theta = zeros(T, 3);
    Cparams.fmat = Tdata.fmat;
    Cparams.all_ftypes = Tdata.all_ftypes;
    Cparams.alphas = zeros(1, T);
    Cparams.T = T;

    % initalise weights
    ws = 1/(2*m) * (ys == -1) + 1/(2*(n-m)) * (ys == 1);

    for t=1:T
        ws = ws ./ sum(ws);
        
        numFeatures = size(FX, 1);
        weakclassifiers = zeros(numFeatures, 3);
        for j=1:size(weakclassifiers, 1)
            [theta, p, err] = LearnWeakClassifier(ws, FX(j, :), ys);
            weakclassifiers(j, :) = [theta, p, err];
        end
        
        [~, minidx] = min(weakclassifiers(:, 3));
        theta = weakclassifiers(minidx, 1);
        parity = weakclassifiers(minidx, 2);
        err = weakclassifiers(minidx, 3);

        alpha = 0.5 * log((1 - err) / err);
        
        % update weights 
        ws = ws .* exp(-alpha * ys .* ((parity * FX(minidx, :) < parity * theta) * 2 - 1));        
        
        Cparams.theta(t, :) = [minidx, theta, parity];
        Cparams.alphas(t) = alpha;
    end
end


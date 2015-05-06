function Cparams = BoostingAlg(Tdata, T)
    FX = Tdata.fmat * Tdata.ii_ims;
    m = sum(Tdata.ys == -1);
    n = size(Tdata.ys, 2);
    
    %Cparams = struct;
    Cparams.theta = zeros(T, 3);
    Cparams.fmat = Tdata.fmat;
    Cparams.all_ftypes = Tdata.all_ftypes;
    Cparams.alphas = zeros(1, T);

    % initalise weights
    ws = 1/(2*m) * (Tdata.ys == -1) + 1/(2*(n-m)) * (Tdata.ys == 1);

    for t=1:T
        ws = ws ./ sum(ws);
        
        % change to run more features
        sz = 1000; %size(FX, 1);
        weakclassifiers = zeros(sz, 3);
        for j=1:size(weakclassifiers, 1)
            [theta, p, err] = LearnWeakClassifier(ws, FX(j, :), Tdata.ys);
            weakclassifiers(j, :) = [theta, p, err];
        end
        
        [~, minidx] = min(weakclassifiers(:, 3));
        theta = weakclassifiers(minidx, 1);
        parity = weakclassifiers(minidx, 2);
        err = weakclassifiers(minidx, 3);

        alpha = 0.5 * log((1 - err) / err);
        
        % update weights 
        ws = ws .* exp(-alpha * Tdata.ys .* ((parity * FX(minidx, :) < parity * theta) * 2 - 1));        
        
        Cparams.theta(t, :) = [minidx, theta, parity];
        Cparams.alphas(t) = alpha;
    end
end


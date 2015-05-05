function [theta, p, err] = LearnWeakClassifier(ws, fs, ys)
    pos_mu = sum(ws .* fs .* (1 + ys)) / sum(ws .* (1 + ys));
    neg_mu = sum(ws .* fs .* (1 - ys)) / sum(ws .* (1 - ys));
    
    theta = 0.5 * (pos_mu + neg_mu);
    
    eps_neg = 0.5 * sum(ws .* abs(ys - ((-fs < -theta) * 2 - 1)));
    eps_pos = 0.5 * sum(ws .* abs(ys - ((fs < theta) * 2 - 1)));
    
    if (eps_neg < eps_pos)
        p = -1;
        err = eps_neg;
    else
        p = 1;
        err = eps_pos;
    end
    
end


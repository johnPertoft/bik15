function [mu, W, D] = PCA_Basis(ims)    
    % each column represents one image's pixels
    X = zeros(size(ims{1}, 1) * size(ims{1}, 2), size(ims, 2));
    for i=1:size(ims, 2)
        [imN mu s] = Normalize(ims{i}(:));
        X(:, i) = imN;
    end
    
    [d n] = size(X);
    mu = mean(X, 2); % mean for each dimension (row)
    Xc = X - repmat(mu, 1, n);
    
    if (d > n)
        % too high dimensional, use trick
        C1 = (Xc' * Xc) / n;
        [V, D] = eig(C1);
        W = Xc * V; % TODO: need to transform D too?
    else
        C = (Xc * Xc') / n;
        [W, D] = eig(C);
    end
    
    % normalise each eigenvector
    for i=1:size(W, 2)
        W(:, i) = W(:, i) / norm(W(:, i), 2);
    end
end


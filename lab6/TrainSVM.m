function [w, b] = TrainSVM(Xtrain, ys, lambda, maxIterations)
[d, n] = size(Xtrain);

w = zeros(d, 1);
b = 0;

t = 1;
for e=1:maxIterations
    inds = randperm(n);
    for i=inds
        eta_t = 1 / (lambda * t);
        w = w * (1 - eta_t * lambda); % common update step
        v = ys(i) * (w' * Xtrain(:, i) + b);
        if v < 1
            w = w + eta_t * ys(i) * Xtrain(:, i);
            b = b + eta_t * ys(i);
        end
        t = t + 1;
    end
    
    % normalize
    a = 1 / (sqrt(lambda) * norm(w));
    if (a < 1)
        w = w * a;
        b = b * a;
    end
end
end


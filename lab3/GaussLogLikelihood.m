function [lvals] = GaussLogLikelihood(xs, mu, sig)
    d = size(xs, 2);
    function p = gloglikelihood(x)
        p = -0.5 * d * log(2*pi) - 0.5 * log(det(sig)) - 0.5 * (x - mu) * inv(sig) * (x - mu)';
    end

    % can this be done with bsxfun or arrayfun instead?
    lvals = zeros(size(xs, 1), 1);
    for r=1:size(xs, 1)
        lvals(r) = gloglikelihood(xs(r, :));
    end

end


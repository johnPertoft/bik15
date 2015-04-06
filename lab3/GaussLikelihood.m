function [lvals] = GaussLikelihood(xs, mu, sig)
%     d = size(xs, 2);
%     function p = glikelihood(x)
%         exponent = -0.5 * (x - mu) * inv(sig) * (x - mu)';
%         p = (1 / sqrt(det(sig) * (2*pi)^d)) * exp(exponent);
%     end
% 
%     % can this be done with bsxfun or arrayfun instead?
%     lvals = zeros(size(xs, 1), 1);
%     for r=1:size(xs, 1)
%         lvals(r) = glikelihood(xs(r, :));
%     end
    
    lvals = mvnpdf(xs, mu, sig);
end


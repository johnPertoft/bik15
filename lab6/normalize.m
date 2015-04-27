function [Xn, mu, sd] = normalize(X)
% normalise each row (dimension)
n = size(X, 2);
mu = mean(X, 2);
sd = std(X, 0, 2);
Xn = bsxfun(@rdivide, (X - repmat(mu, 1, n)), sd);
end


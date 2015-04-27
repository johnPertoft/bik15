function [X, mu, sd] = extractDescriptor(cellims, CELL_SIZE)
n = length(cellims);
X = [];
for i=1:n
    im = im2single(cellims{i});
    hog = vl_hog(im, CELL_SIZE);
    if (i == 1)
        X = zeros(numel(hog), n);
    end
    X(:, i) = hog(:);
end

% normalise each row (dimension)
mu = mean(X, 2);
sd = std(X, 0, 2);
X = bsxfun(@rdivide, (X - repmat(mu, 1, n)), sd);
end


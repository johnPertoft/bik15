function [X] = extractHOG(cellims, CELL_SIZE)
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
end


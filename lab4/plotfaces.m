function [] = plotfaces(W, width, height)

% plot top 20 eigenfaces
eigenfaces = cell(1, 20);
for i=0:19
    v = reshape(W(:, size(W, 2) - i), [height, width]);
    v = (v - min(v(:))) / (max(v(:)) - min(v(:)));
    eigenfaces(1, i+1) = {v};
end

figure
montage(eigenfaces, 'Size', [4 5]);


end


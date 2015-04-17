function [rim] = ReconstructFace(im, mu, w, dims, nv)
    % reshape and normalize
    originalDim = size(im);
    imR = imresize(im, dims);
    [imN, mu, s] = Normalize(imR(:));
    
    % project on to eigenfaces (dot product)
    EF = w(:, end - (nv - 1):end);
    proj = EF' * (imN - mu);    % projection
    rim = mu + EF * proj;       % use projection coefficients in weighted sum
    rim = reshape(rim, dims) * s + mu; % revert normalisation
    rim = imresize(rim, originalDim);
end


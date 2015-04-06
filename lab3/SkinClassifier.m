function [bim] = SkinClassifier(img, keepColor)
    im = double(img) / 255;
    im = reshape(im, [], 3);
    classifier = load('skin_bayes_classifier.mat');

    skinL = GaussLikelihood(im, classifier.skin_mu, classifier.skin_sig);
    nonskinL = GaussLikelihood(im, classifier.nonskin_mu, classifier.nonskin_sig);
    lratio = skinL ./ nonskinL;
    
    % classified pixels
    cp = (lratio > classifier.theta);
    if (keepColor)
         bim2D = bsxfun(@times, im, cp);
    else
         bim2D = sign(bsxfun(@times, im, cp));
    end
   

    % reshape back to 3d structure
    bim = zeros(size(img));
    bim(:, :, 1) = reshape(bim2D(:, 1), [size(img, 1) size(img, 2)]);
    bim(:, :, 2) = reshape(bim2D(:, 2), [size(img, 1) size(img, 2)]);
    bim(:, :, 3) = reshape(bim2D(:, 3), [size(img, 1) size(img, 2)]);
end


clear;

runTraining = 0;

if (runTraining)
    [skin_mu, skin_sig, nonskin_mu, nonskin_sig, theta, skin_test, nonskin_test] = TrainSkinClassifier();
    
    % test performance using the estimated theta
    pixs_test = [skin_test; nonskin_test];
    labels_test = zeros(size(pixs_test, 1), 1);
    n1 = size(skin_test, 1);
    labels_test(1:n1) = 1;
    skin_likelihood = GaussLikelihood(pixs_test, skin_mu, skin_sig);
    nonskin_likelihood = GaussLikelihood(pixs_test, nonskin_mu, nonskin_sig);
    lratio = skin_likelihood ./ nonskin_likelihood;
    accuracy = 1 - sum(abs((lratio > theta) - labels_test)) / size(labels_test, 1)
end


img = imread('bw.jpg'); % good, training data is not that racist! 
bim = SkinClassifier(img, 1);
%imagesc(bim);
montage({img, bim}, 'Size', [1 2]);
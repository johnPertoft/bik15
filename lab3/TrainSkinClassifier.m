function [skin_mu, skin_sig, nonskin_mu, nonskin_sig, theta, skin_test, nonskin_test] = TrainSkinClassifier()

skin_d = load('skin_pixel_data.mat');
nonskin_d = load('nonskin_pixel_data.mat');

% cast all data to double and divide by 255.0
skin_train = double(skin_d.skin_pixs_train) / 255.0;
skin_val = double(skin_d.skin_pixs_val) / 255.0;
skin_test = double(skin_d.skin_pixs_test) / 255.0;
nonskin_train = double(nonskin_d.nonskin_pixs_train) / 255.0;
nonskin_val = double(nonskin_d.nonskin_pixs_val) / 255.0;
nonskin_test = double(nonskin_d.nonskin_pixs_test) / 255.0;

% calculate mean and covariance of training data
skin_mu = mean(skin_train);
skin_sig = cov(skin_train);
nonskin_mu = mean(nonskin_train);
nonskin_sig = cov(nonskin_train);

% threshold estimation using validation set
pixs_val = [skin_val; nonskin_val];
labels_val = zeros(size(pixs_val, 1), 1);
n1 = size(skin_val, 1);
labels_val(1:n1) = 1;
theta = Val_Theta(pixs_val, skin_mu, skin_sig, nonskin_mu, nonskin_sig, labels_val, 0.5:.1:2);

save('skin_bayes_classifier.mat', 'skin_mu', 'skin_sig', 'nonskin_mu', 'nonskin_sig', 'theta');

end


run('../vlfeat-0.9.20/toolbox/vl_setup.m');
clear;

ped_train = load('pedestrian_training.mat');
ped_valid = load('pedestrian_validation.mat');
ped_test = load('pedestrian_test.mat');

CELL_SIZE = 4;
n = length(ped_train.ims);

xtrain_hog = extractHOG(ped_train.ims, CELL_SIZE);
[xtrain, mu, sd] = normalize(xtrain_hog);
ytrain = ped_train.y;

lambda = 0.0001;
T = 40;
[w, b] = TrainSVM(xtrain, ytrain, lambda, T);

xtest_hog = extractHOG(ped_test.ims, CELL_SIZE);
xtest = bsxfun(@rdivide, (xtest_hog - repmat(mu, 1, size(xtest_hog, 2))), sd);
ytest = ped_test.y;

% measure accuracy on training set
y_est = sign(w' * xtrain + b);
numCorrect = sum(y_est' == ytrain);
accuracy = numCorrect / n

% measure accuracy on test set
y_est = sign(w' * xtest + b);
numCorrect = sum(y_est' == ytest);
accuracy = numCorrect / n
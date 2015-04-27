clear;

BushData = load('data_for_opt_exercise.mat');

% temp
imshow(BushData.ims{1})
hold on
plot(BushData.bb(1, :), BushData.bb(2, :), 'ro');
hold off


% TODO:
% extract the bushvectors which is the image data of the bounding boxes of
% each image
clear;
addpath('./images');

% Gray scale image plot
im = imread('bike_small_gray.jpg');
fig = figure;
imagesc(im);
axis equal
colormap(gray)

% Red X plot
figure(fig);
hold on;
plot(500, 355, 'rx', 'LineWidth', 2, 'MarkerSize', 12);

plot([500, 500], [355, 595], 'r-', 'LineWidth', 2)
pix_int = im(355:595, 500);
y_values = 355:595;
fig1 = figure;
figure(fig1);
plot(y_values, pix_int, 'b-')

% Reshape of image and accessing of certain pixel
pixs = im(:);
disp([size(pixs)]);
disp(size(im, 1) * size(im, 2));
disp(pixs(size(im, 1) * (500-1) + 355));
disp(im(355, 500));

% Color image plot
col_im = imread('bike_small.jpg');
col_fig = figure;
col_im
imagesc(col_im);
axis equal

R = double(col_im(:, :, 1));
G = double(col_im(:, :, 2));
B = double(col_im(:, :, 3));
figure(col_fig);
montage({col_im, R, G, B}, 'Size', [1, 4]);
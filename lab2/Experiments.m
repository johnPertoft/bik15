clear;
addpath('./Pics/Aligned_Pics');
addpath('./Pics/Misaligned_Pics');

col_img = imread('eye001.png');
img = single(rgb2gray(col_img));
img = (img - mean(img(:)))/ std(img(:));

fs = img(:);

%stem(fs(1:10:end));

[fs, xx] = hist(img(:), 30);
fs = fs(:)/sum(fs);
stem(xx, fs);

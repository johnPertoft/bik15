clear;
addpath('./images');

col_img = imread('Flowers.jpg');

[pim, dim] = MakeDichromatIms(col_img);

montage({col_img, uint8(pim), uint8(dim)}, 'Size', [1, 3]);

imwrite(pim/256, 'result_images/pRes.png', 'png');
imwrite(dim/256, 'result_images/dRes.png', 'png');
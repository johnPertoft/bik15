run('../VLFeat/vlfeat-0.9.20/toolbox/vl_setup.m')
clear;
addpath('./Pics/Aligned_Pics');
addpath('./Pics/Misaligned_Pics');

col_img = imread('Aligned_Pics/eye001.png');
img = single(rgb2gray(col_img));
img = (img - mean(img(:)))/ std(img(:));

% Pixel intensities
%fs = img(:);
%stem(fs(1:10:end));

% Histogram of image
% [fs, xx] = hist(img(:), 30);
% fs = fs(:)/sum(fs);
% stem(xx, fs);

% Grid histogram
% fs = ExtractGridHistogram(img, 2, 30);
% stem(fs)

% SIFT descriptor
% [fc, fs] = ExtractSiftDescriptor(img);
% figure(1);
% hold off; imagesc(img); colormap(gray); axis equal;
% hold on;
% h3 = vl_plotsiftdescriptor(fs, fc);
% set(h3, 'color', 'r', 'Linewidth', 3);

%Compute all descriptors and distance matrix
alignedPics = 'Pics/Aligned_Pics/';
misalignedPics = 'Pics/Misaligned_Pics/';
Fs = ComputeDescriptors(alignedPics, 2, 30);
dists = cell(1, 4);
for i=1:4
    D = ComputeDistanceMatrix(Fs{i});
    ni = size(Fs{i}, 2);
    dists{i} = D;
    Y = mdscale(D, 2);
    figure;
    imagesc(D);
%     plot(Y(1:ni/2, 1), Y(1:ni/2, 2), 'rx', 'MarkerSize', 10);
%     hold on;
%     plot(Y(ni/2+1:end, 1), Y(ni/2+1:end, 2), 'bo', 'MarkerSize', 10);
%     axis equal;
end


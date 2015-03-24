function [PIM, DIM] = MakeDichromatIms(im)
% Digitally simulating dichromat vision

% Reshape to 3xN, each column is a pixel
rgb = reshape(im, [], 3)';
rgb = (double(rgb) / 255) .^ 2.2;

% Protanopes
rgb_p = 0.99502 * rgb + 0.003974;

% Deuteranopes
rgb_d = 0.957237 * rgb + 0.0213814;

% LMS transform matrix
M = [17.8824 43.5161 4.11935;
    3.45565 27.1554 3.86714;
    0.0299566 0.184309 1.46709];

% Protanope projection matrix
P = [0 2.02344 -2.52591;
    0 1 0;
    0 0 1];

% Deuteranope projection matrix
D = [1 0 0;
    0.494207 0 1.24827;
    0 0 1];

% Apply transforms
pim = inv(M) * (P * (M * rgb_p));
dim = inv(M) * (D * (M * rgb_d));

% Invert common step
pim = 255 * (pim .^ (1/2.2));
dim = 255 * (dim .^ (1/2.2));

% TODO: reshape to 3D again
% TODO: bleh, skip the for loops please
PIM = zeros(size(im, 1), size(im, 2), 3);
DIM = zeros(size(im, 1), size(im, 2), 3);
i = 1;
for col=1:size(im, 2)
    for row=1:size(im, 1)
        PIM(row, col, 1) = pim(1, i);
        PIM(row, col, 2) = pim(2, i);
        PIM(row, col, 3) = pim(3, i);
        DIM(row, col, 1) = dim(1, i);
        DIM(row, col, 2) = dim(2, i);
        DIM(row, col, 3) = dim(3, i);
        i = i + 1;
    end
end
end
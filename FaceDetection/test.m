[im, ii_im] = LoadImage('resources/TrainingImages/FACES/face00001.bmp');

% Sanity check 1
if (0)
    dinfo1 = load('resources/DebugInfo/debuginfo1.mat');
    eps = 1e-6;
    s1 = sum(abs(dinfo1.im(:) - im(:)) < eps)
    s2 = sum(abs(dinfo1.ii_im(:) - ii_im(:)) < eps)
end

% Sanity check 2
if (0)
    x = 10;
    y = 10;
    w = 5;
    h = 4;
    b_vec = VecBoxSum(x, y, w, h, 19, 19);
    A1 = b_vec * ii_im(:)
    A2 = sum(sum(im(y:y+h-1, x:x+w-1)))
end

% Sanity check 3
if (0)
    ftype_vec = VecFeature([1, x, y, w, h], 19, 19);
    A1 = ftype_vec * ii_im(:)
    b0 = sum(sum(im(y:y+h-1, x:x+w-1)));
    b1 = sum(sum(im(y+h:y+2*h-1, x:x+w-1)));
    A2 = b0 - b1
end

% debug 2
if (1)
    dinfo2 = load('resources/DebugInfo/debuginfo2.mat');
    fs = dinfo2.fs; W=19; H=19;
    abs(fs(1) - VecFeature(dinfo2.ftypes(1, :), W, H)* ii_im(:)) < eps
    abs(fs(2) - VecFeature(dinfo2.ftypes(2, :), W, H)* ii_im(:)) < eps
    abs(fs(3) - VecFeature(dinfo2.ftypes(3, :), W, H)* ii_im(:)) < eps
    abs(fs(4) - VecFeature(dinfo2.ftypes(4, :), W, H)* ii_im(:)) < eps
end

imagesc(ii_im)
colormap('gray')


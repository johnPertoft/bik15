[im, ii_im] = LoadImage('resources/TrainingImages/FACES/face00001.bmp');
eps = 1e-6;

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
if (0)
    dinfo2 = load('resources/DebugInfo/debuginfo2.mat');
    fs = dinfo2.fs; W=19; H=19;
    abs(fs(1) - VecFeature(dinfo2.ftypes(1, :), W, H)* ii_im(:)) < eps
    abs(fs(2) - VecFeature(dinfo2.ftypes(2, :), W, H)* ii_im(:)) < eps
    abs(fs(3) - VecFeature(dinfo2.ftypes(3, :), W, H)* ii_im(:)) < eps
    abs(fs(4) - VecFeature(dinfo2.ftypes(4, :), W, H)* ii_im(:)) < eps
end

% debug 3
if (0)
    W = 19;
    H = 19;
    all_ftypes = EnumAllFeatures(W, H);
    fmat = VecAllFeatures(all_ftypes, W, H);
    
    dinfo3 = load('resources/DebugInfo/debuginfo3.mat');
    fmat = VecAllFeatures(dinfo3.all_ftypes, W, H);
    sum(abs(dinfo3.fs - fmat * ii_im(:)) < eps)
end

if (0)
    dinfo4 = load('resources/DebugInfo/debuginfo4.mat');
    ni = 100;
    ii_ims = LoadImDataDir('resources/TrainingImages/FACES', ni);
    fmat = VecAllFeatures(dinfo4.all_ftypes, 19, 19);
    sum(sum(abs(dinfo4.fs - fmat * ii_ims)) < eps)
end

if (0)
    dinfo5 = load('resources/DebugInfo/debuginfo5.mat');
    train_inds = dinfo5.train_inds;
    all_ftypes = dinfo5.all_ftypes;
    SaveTrainingData(all_ftypes, train_inds, 'training_data.mat');
end

% checkpoint 2
if (0)
    Tdata = load('training_data.mat');
    fs = Tdata.fmat(12028, :) * Tdata.ii_ims;
    ws = ones(1, size(Tdata.ii_ims, 2)) / size(Tdata.ii_ims, 2);
    [theta, p, err] = LearnWeakClassifier(ws, fs, Tdata.ys)
    faces = fs(Tdata.ys == 1);
    nonfaces = fs(Tdata.ys == -1);
    
    [face_counts, facecenters] = hist(faces, 10);
    [nonface_counts, nonfacecenters] = hist(nonfaces, 10);
    plot(facecenters, face_counts / sum(face_counts), 'ro-');
    hold on;
    plot(nonfacecenters, nonface_counts / sum(nonface_counts), 'bo-');
    hold off;
    
end

if (0)
    fpic = MakeFeaturePic([4, 5, 5, 5, 5], 19, 19);
    imagesc(fpic);
    colormap('gray');
end


if (0)
    Tdata = load('training_data.mat');
    cpic = MakeClassifierPic(Tdata.all_ftypes, [5192, 12765], [1.8725, 1.467], [1 -1], 19, 19);
    imagesc(cpic);
    colormap('gray');
end

% checkpoint 2
if (0)
    Tdata = load('training_data.mat');
    %Cparams = BoostingAlg(Tdata, 10)
    
    idxs = Cparams.theta(:, 1); 
    W = Tdata.W;
    H = Tdata.H;
    fpic1 = MakeFeaturePic(Cparams.all_ftypes(idxs(3), :), W, H);
    imagesc(fpic1);
    colormap('gray');
    
    %cpic = MakeClassifierPic(Cparams.all_ftypes, Cparams.theta(:, 1)', Cparams.alphas, Cparams.theta(:, 3)', W, H);
    %imagesc(cpic);
    
% dinfo6 = load('resources/DebugInfo/debuginfo6.mat');
% T = dinfo6.T;
% Cparams = BoostingAlg(Tdata, T);
% sum(abs(dinfo6.alphas - Cparams.alphas') > eps)
% sum(abs(dinfo6.Thetas(:) - Cparams.theta(:)) > eps)
end

% checkpoint 3
if (1)
    dinfo7 = load('resources/DebugInfo/debuginfo7.mat');
    Tdata = load('training_data.mat');
    %Cparams = BoostingAlg(Tdata, dinfo7.T);
    Cparams = load('classifier.mat');
    scs = ApplyDetector(Cparams, Tdata.ii_ims);
    scoreforface0001 = scs(1) % test score for face0001.bmp
    
    % plot histogram of face and nonface scores
%     numF = sum(Tdata.ys == 1);
%     numNF = sum(Tdata.ys == -1);
%     face_scores = scs(1:numF);
%     nonface_scores = scs(numF+1:end);
%     [fc, fcenters] = hist(face_scores, 100);
%     [nfc, nfcenters] = hist(nonface_scores, 100);
%     plot(fcenters, fc, 'ro-');
%     hold on;
%     plot(nfcenters, nfc, 'bo-');
%     plot(-1.55, 0:1200, 'g-');
%     plot(1.75, 0:1200, 'g-');

    thresh = ComputeROC(Cparams, Tdata)
    
end

if (0)
    %SaveClassifier(100);
    Cparams = load('classifier.mat');
    
    tic
    im = imread('resources/TestImages/gerobe.jpg');
    %im = imresize(im, 0.5);
    %[dets, scs] = ScanImageFixedSize(Cparams, im);
    dets = ScanImageOverScale(Cparams, im, 0.02, 0.8, 0.05);
    %dets = ScanImageOverScale(Cparams, im, 0.7, 0.8, 0.01);
    dets = PruneDetections(dets);
    
    im = insertShape(im, 'Rectangle', dets, 'Color', 'red');
    %im = insertText(im, bsxfun(@plus, dets(:, [1, 2]), [19, 0]), scs, 'FontSize', 10, 'BoxOpacity', 0.0, 'TextColor', 'green');
    imshow(im);
    toc

end

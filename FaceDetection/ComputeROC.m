function thresh = ComputeROC(Cparams, Tdata)
unused_train_inds = setdiff(1:size(Tdata.ys, 2), Tdata.train_inds);

scs = ApplyDetector(Cparams, Tdata.ii_ims(:, unused_train_inds));
ys = Tdata.ys(:, unused_train_inds);
faces = ys == 1;
nonfaces = ys == -1;

[minScore, ~] = min(scs);
[maxScore, ~] = max(scs);

found_thresh = 0;
numSteps = 500;
tprs = [];
fprs = [];

for threshold=linspace(minScore, maxScore, numSteps)
    predictions = ((scs > threshold) * 2 - 1);
    
    face_predictions = predictions == 1;
    nonface_predictions = predictions == -1;
    
    true_pos = sum(face_predictions .* faces);
    false_pos = sum(face_predictions .* nonfaces);
    true_neg = sum(nonface_predictions .* nonfaces);
    false_neg = sum(nonface_predictions .* faces);
    
    tpr = true_pos / (true_pos + false_neg);
    fpr = false_pos / (true_neg + false_pos);
    
    if (tpr < 0.7 && ~found_thresh)
        thresh = threshold;
        found_thresh = 1;
    end
    
    tprs = [tprs tpr];
    fprs = [fprs fpr];
end

plot(fprs, tprs);

end


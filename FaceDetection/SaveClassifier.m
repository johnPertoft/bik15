function SaveClassifier(T)
    Tdata = load('training_data.mat');
    Cparams = BoostingAlg(Tdata, T);
    Cparams.thresh = ComputeROC(Cparams, Tdata);
    save('classifier.mat', '-struct', 'Cparams');
end


function SaveTrainingData(all_ftypes, train_inds, s_fn)
W = 19;
H = 19;
ii_ims_faces = LoadImDataDir('resources/TrainingImages/FACES');
ii_ims_nofaces = LoadImDataDir('resources/TrainingImages/NFACES');

ii_ims = [ii_ims_faces ii_ims_nofaces];
ys = [ones(1, size(ii_ims_faces, 2)), -1 * ones(1, size(ii_ims_nofaces, 2))];
fmat = VecAllFeatures(all_ftypes, W, H);

save(s_fn, 'ii_ims', 'ys', 'fmat', 'all_ftypes', 'train_inds', 'W', 'H');

end


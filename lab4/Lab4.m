clear;

plotBush = 0;
plotSmall = 0;

Bush = load('george_w_bush_faces_aligned.mat');
[mu, W, D] = PCA_Basis(Bush.ims);
% TODO: width and height are flipped in because otherwise it was wrong so
% change this somewhere
if (plotBush)
    plotfaces(W, size(Bush.ims{1}, 2), size(Bush.ims{1}, 1));
    plotcumsum(D);
end

Small = load('small_faces.mat');
[mu, W, D] = PCA_Basis(Small.ims);
if (plotSmall)
    plotfaces(W, size(Small.ims{1}, 2), size(Small.ims{1}, 1));
    plotcumsum(D);
end

% reconstruction of bush face using the small faces
im = Bush.ims{9}(35:end-10, :);
dims = size(Small.ims{1});
nvs = [1 10 20 50 100 150 200 250 300];
for nv=nvs
    recIm = ReconstructFace(im, mu, W, dims, nv);
    fstr = ['Pics/Bush/recIm_' num2str(nv) '.png'];
    imwrite(recIm, fstr, 'png');
end

%montage({recIm}, 'Size', [1, 1]);
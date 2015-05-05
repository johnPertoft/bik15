function [fmat] = VecAllFeatures(all_ftypes, W, H)
nf = size(all_ftypes, 1);
fmat = zeros(nf, W * H);
for i=1:nf
    fmat(i,:) = VecFeature(all_ftypes(i, :), W, H);
end
end


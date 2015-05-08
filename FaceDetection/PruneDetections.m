function fdets = PruneDetections(dets)
nd = size(dets, 1);
D = zeros(nd, nd);
p = 0.88;

for i=1:nd
    for j=i+1:nd
        A = dets(i, 3) * dets(i, 4);
        B = dets(j, 3) * dets(j, 4);
        intersection = rectint(dets(i, :), dets(j, :));
        D(i, j) = intersection / (A + B - intersection) > p;
        D(j, i) = D(i, j);
    end
end

[S, C] = graphconncomp(sparse(D));
fdets = zeros(S, 4);

for s=1:S
    comp_dets = dets(C == s, :);
    fdets(s, :) = [round(mean(comp_dets(:, [1, 2]))) 19 19];
end

end


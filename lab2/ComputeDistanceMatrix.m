function [D] = ComputeDistanceMatrix(Fs)
    ni = size(Fs, 2);
    %D = pdist(Fs', 'euclidean'); TODO use this instead?
    D = zeros(ni, ni);
    for i=1:ni
        f1 = Fs(:, i);
        for j=1:ni
            f2 = Fs(:, j);
            D(i, j) = sqrt(sum((f1 - f2) .* (f1 - f2)));
        end
    end
end


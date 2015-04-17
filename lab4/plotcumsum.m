function [] = plotcumsum(D)
    D = diag(D)
    idx = find(cumsum(fliplr(D')) > sum(D) * 0.9);
    idx = idx(1);
    figure
    plot(1:size(D, 1), cumsum(fliplr(D'))), title(idx);
    hold on;
    plot(1:size(D, 1), sum(D) * 0.9);
end


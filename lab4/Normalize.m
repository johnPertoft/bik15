function [mn, mu, s] = Normalize(m)
    m = double(m);
    mu = mean(m);
    s = std(m);
    mn = (m - mu) / s;
end


function [cpic] = MakeClassifierPic(all_ftypes, chosen_f, alphas, ps, W, H)
    cpic = zeros(H, W);
    weights = alphas .* ps;
    
    for i=size(chosen_f)
        cpic = cpic + weights(i) * MakeFeaturePic(all_ftypes(chosen_f(i), :), W, H);
    end
end


function [theta] = Val_Theta(pix_vals, skin_mu, skin_sig, nonskin_mu, nonskin_sig, labels_val, thetas)
    % compute likelihoods using both models
    skin_likelihood = GaussLikelihood(pix_vals, skin_mu, skin_sig);
    nonskin_likelihood = GaussLikelihood(pix_vals, nonskin_mu, nonskin_sig);
    lratio = skin_likelihood ./ nonskin_likelihood;
    
    theta = thetas(1);
    bestAcc = 0;
    for t=thetas
        % measure accuracy
        acc = 1 - sum(abs((lratio > t) - labels_val)) / size(labels_val, 1);
        if (acc > bestAcc)
            theta = t;
            bestAcc = acc;
        end
    end
end


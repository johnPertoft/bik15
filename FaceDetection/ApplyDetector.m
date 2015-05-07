function scs = ApplyDetector(Cparams, ii_ims)
    sum = 0;
    for t=1:Cparams.T
        fidx = Cparams.theta(t, 1);
        theta = Cparams.theta(t, 2);
        parity = Cparams.theta(t, 3);
        fx = Cparams.fmat(fidx, :) * ii_ims;
        r = Cparams.alphas(t) * ((parity * fx < parity * theta) * 2 - 1); 
        sum = sum + r;
    end
    
    scs = sum;
end


function scs = ApplyDetector(Cparams, ii_ims)
    FX = Cparams.fmat * ii_ims;

    sum = 0;
    for t=1:Cparams.T
        fidx = Cparams.theta(t, 1);
        theta = Cparams.theta(t, 2);
        parity = Cparams.theta(t, 3);
        r = Cparams.alphas(t) * ((parity * FX(fidx, :) < parity * theta) * 2 - 1);
        
        sum = sum + r;
    end
    
    scs = sum;
end


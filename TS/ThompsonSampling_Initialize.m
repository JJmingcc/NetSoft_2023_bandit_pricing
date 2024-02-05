function [alphas, betas, gainThompsonSampling, ArmPlayed] = ThompsonSampling_Initialize(K, alpha0, beta0)
    if( alpha0 <=0 )
        error('alpha0 must be > 0');
    end
    if(beta0 <= 0)
        error('beta0 must be > 0');
    end
    alphas = ones(1,K)*alpha0;
    betas = ones(1,K)*beta0;
    gainThompsonSampling = [];
    ArmPlayed = [];
end
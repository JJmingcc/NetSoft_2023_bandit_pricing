function [ArmToPlay]= ThompsonSampling_RecommendArm(alphas, betas, V)
    Theta = [];
    for v = 1:V
        Theta = [Theta betarnd(alphas(v),betas(v))]; % Sampling from Beta distribution
    end
    ArmToPlay = PickingMaxIndexArm(Theta);
end
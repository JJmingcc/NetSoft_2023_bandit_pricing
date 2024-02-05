function [alphas, betas, gainThompsonSampling, ArmsPlayed]= ThompsonSampling_ReceiveReward(alphas, betas, rew, ArmChosen, gainThompsonSampling, ArmsPlayed)
    if( (rew <0) + (rew > 1) ~= 0)
        error('reward must be between 0 and 1')
    end
    gainThompsonSampling = [gainThompsonSampling rew];
    ArmsPlayed = [ArmsPlayed ArmChosen];
%     if((rew == 0) + (rew == 1) == 0)
%         rew = rand() < rew; % for non Bernoulli Distribution: g
%     end
    alphas(ArmChosen) = alphas(ArmChosen) + (rew == 1);
    betas(ArmChosen) = betas(ArmChosen) + (rew == 0);
end
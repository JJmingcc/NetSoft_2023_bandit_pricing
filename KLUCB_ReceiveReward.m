function [Expected_KLUCB, NbrPlayArm, gain_KLUCB, ArmsPlayed]= KLUCB_ReceiveReward(Expected_KLUCB, NbrPlayArm, rew, ArmChosen, gain_KLUCB, ArmsPlayed)
    if(length(Expected_KLUCB)< ArmChosen)
        error('Undefined arm');
    end
    if( rew < 0 + rew > 1)
        error('reward must be between 0 and 1')
    end
    % expected_mean of rew updating rule
    Expected_KLUCB(ArmChosen) = (Expected_KLUCB(ArmChosen)*NbrPlayArm(ArmChosen) + rew)./(NbrPlayArm(ArmChosen)+1);
    % Number of arm that are decided to play
    NbrPlayArm(ArmChosen) = NbrPlayArm(ArmChosen) + 1;
    % Update the 
    ArmsPlayed = [ArmsPlayed ArmChosen];
    % Update the
    gain_KLUCB = [gain_KLUCB rew]; % Gain Updated
end

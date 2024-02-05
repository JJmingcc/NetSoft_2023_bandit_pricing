function [Expected_KLBWK, NbrPlayArm, gain_KLBWK, ArmsPlayed]= KLBWK_ReceiveReward(Expected_KLBWK, NbrPlayArm, rew, ArmChosen, gain_KLBWK, ArmsPlayed)   

    if(length(Expected_KLBWK)< ArmChosen)
        error('Undefined arm');
    end
    if( rew < 0 + rew > 1)
        error('reward must be between 0 and 1')
    end
    % expected_mean of rew updating rule
    Expected_KLBWK(ArmChosen) = (Expected_KLBWK(ArmChosen)*NbrPlayArm(ArmChosen) + rew)./(NbrPlayArm(ArmChosen)+1);
    % Number of arm that are decided to play
    NbrPlayArm(ArmChosen) = NbrPlayArm(ArmChosen) + 1;
    % Update the 
    ArmsPlayed = [ArmsPlayed ArmChosen];
    % Update the
    gain_KLBWK = [gain_KLBWK rew]; % Gain Updated


end

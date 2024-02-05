function [Expected_EG, NbrPlayArm, gainEG, ArmsPlayed]= EG_ReceiveReward(Expected_EG, NbrPlayArm, rew, ArmChosen, gainEG, ArmsPlayed)
%   gainUCB = [gainUCB reward]; % Gain Updated
    if(length(Expected_EG)< ArmChosen)
        error('Undefined arm');
    end
    if( rew < 0 + rew > 1)
        error('reward must be between 0 and 1')
    end
    % expected_mean of rew updating rule
    Expected_EG(ArmChosen) = (Expected_EG(ArmChosen)*NbrPlayArm(ArmChosen) + rew)./(NbrPlayArm(ArmChosen)+1);
    % Number of arm that are decided to play
    NbrPlayArm(ArmChosen) = NbrPlayArm(ArmChosen) + 1;
    % Update the 
    ArmsPlayed = [ArmsPlayed ArmChosen];
    % Update the
    gainEG = [gainEG rew]; % Gain Updated
end

function [Expected_UCB, NbrPlayArm, gainUCB, ArmsPlayed]= MOSS_ReceiveReward(Expected_UCB, NbrPlayArm, rew, ArmChosen, gainUCB, ArmsPlayed)
%   gainUCB = [gainUCB reward]; % Gain Updated
    if(length(Expected_UCB)< ArmChosen)
        error('Undefined arm');
    end
    if( rew < 0 + rew > 1)
        error('reward must be between 0 and 1')
    end
    % expected_mean of rew updating rule
    Expected_UCB(ArmChosen) = (Expected_UCB(ArmChosen)*NbrPlayArm(ArmChosen) + rew)./(NbrPlayArm(ArmChosen)+1);
    % Number of arm that are decided to play
    NbrPlayArm(ArmChosen) = NbrPlayArm(ArmChosen) + 1;
    % Update the 
    ArmsPlayed = [ArmsPlayed ArmChosen];
    % Update the
    gainUCB = [gainUCB rew]; % Gain Updated
end

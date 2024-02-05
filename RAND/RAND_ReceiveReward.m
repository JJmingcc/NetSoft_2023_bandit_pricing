function [Expected_RAND, NbrPlayArm, ArmsPlayed]= RAND_ReceiveReward(Expected_RAND, NbrPlayArm, rew, ArmChosen, ArmsPlayed)
    Expected_RAND(ArmChosen) = (Expected_RAND(ArmChosen)*NbrPlayArm(ArmChosen) + rew)./(NbrPlayArm(ArmChosen)+1);
    NbrPlayArm(ArmChosen) = NbrPlayArm(ArmChosen) + 1;
    ArmsPlayed = [ArmsPlayed ArmChosen];
end
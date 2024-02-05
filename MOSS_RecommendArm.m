function [ArmToPlay,MOSS_ucb]= MOSS_RecommendArm(Expected_MOSS, NbrPlayArm, T)
    MOSS_ucb =  Expected_MOSS + sqrt(max(log(T./(length(NbrPlayArm).*NbrPlayArm)),0)./NbrPlayArm);
    ArmToPlay = PickingMaxIndexArm(MOSS_ucb);
end
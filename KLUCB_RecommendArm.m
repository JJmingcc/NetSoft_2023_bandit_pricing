function [ArmToPlay]= KLUCB_RecommendArm(ExpectedMeans, NbrPlayArm, t, T, HF, c)

    if( t <=0)
        error('Time step invalide. t<=0')
    end
    ucb = SearchingKLUCBIndex(ExpectedMeans, NbrPlayArm, t, T, HF,c);
    ArmToPlay = PickingMaxIndexArm(ucb);
end
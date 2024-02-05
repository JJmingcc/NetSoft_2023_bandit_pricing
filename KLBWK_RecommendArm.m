function [ArmToPlay]= KLBWK_RecommendArm(KLBwK_Aset, ExpectedMeans, NbrPlayArm, t, T, HF, c)

    if( t <=0)
        error('Time step invalide. t<=0')
    end
    ucb = SearchingKLUCBIndex(ExpectedMeans, NbrPlayArm, t, T, HF,c);
    % we could add a avaliable set update
    ArmToPlay = PickingMaxIndexArm(ucb .* KLBwK_Aset);
end
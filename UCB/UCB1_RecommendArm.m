function [ArmToPlay,ucb]= UCB1_RecommendArm(ExpectedMeans,NbrPlayArm,t)
    if(length(ExpectedMeans) ~= length(NbrPlayArm))
        error('Dimension is wrong');
    end
%     if( t <=0)
%         error('Time step invalide. t<=0')
%     end
    ucb = ExpectedMeans + sqrt(2*log(t)./NbrPlayArm); % Expected_mean + concentration_bound (Radius): dim (V*1)
    ArmToPlay = PickingMaxIndexArm(ucb);
end
function [ArmToPlay]= EG_RecommendArm(Expected_EG, NbrPlayArm, epislon_rand, V, t)
    if(length(Expected_EG) ~= length(NbrPlayArm))
        error('Dimension is wrong');
    end
    if( t <=0)
        error('Time step invalide. t<=0')
    end
%     ucb = ExpectedMeans + sqrt(2*log(t)./NbrPlayArm); % Vx1
    prob = rand();
    if prob > epislon_rand
        ArmToPlay = randi([1,V],1); % Choose price vector 
    else
        ArmToPlay = PickingMaxIndexArm(Expected_EG);
    end 
end
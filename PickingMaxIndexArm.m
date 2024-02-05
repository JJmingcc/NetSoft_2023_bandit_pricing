function ArmToPlay = PickingMaxIndexArm(ucb)
    m = max(ucb);
    if ( ~isnan(m));
        I = find(ucb == m);
        ArmToPlay = I(1+floor(length(I)*rand)); % Breaking randomly the tie 
    else
        ArmToPlay = randi(length(ucb));
    end
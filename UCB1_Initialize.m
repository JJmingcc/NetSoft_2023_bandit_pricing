function [ExpectedMeans, NbrPlayArm, gainUCB, ArmsPlayed]= UCB1_Initialize(K)
    gainUCB = [];
    ExpectedMeans = zeros(1,K);
    NbrPlayArm = ones(1,K);
    ArmsPlayed = [];
end
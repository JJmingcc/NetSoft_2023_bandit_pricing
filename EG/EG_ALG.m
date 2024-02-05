function [NbrPlayArm_EG,Cummu_EG_res,Cummu_EG_rew, gainEG, ArmsPlayed_EG, prod_index_EG, Arm_select_EG,time_EG] = EG_ALG(V,M,C,T,price_vec)

% Benchmark: Epislon greedy EG algorithm with knapsack
tic
NbrPlayArm = ones(1,V);
r_est = sum(sum(price_vec));
c_est = ones(M,V);
EG_res = c_est;
EG_rew = r_est;
Cummu_EG_rew = zeros(1,T);
Expected_EG = 1/M * ones(1,V);
ArmsPlayed = [];
gainEG = [];
epislon_rand = 0.1; % Hyper parameter 
ArmChosen = randi([1, length(price_vec)]);
prod_index_EG = [];
Arm_select_EG = [];
% [ExpectedMeans, NbrPlayArm, gainUCB, ArmsPlayed]= UCB1_Initialize(K);
% For Every time, we excuate algorithm
for t = 1:T
    test_Cap = EG_res < C;
    if any(test_Cap(:) == 0)  
        disp('EG_ALG: One of resource is exhausted');
        break;
    else
        [ArmToPlay]= EG_RecommendArm(Expected_EG, NbrPlayArm, epislon_rand, V, t); % Arm recommended by EG 
        % Customer preference generation
        [prod_index,max_uti] = customer_generation(M,price_vec,ArmToPlay);
         if max_uti > 0
            % if price is accepted, the reward = selected price
            ArmChosen = ArmToPlay;
            res_cons = 1;
            rew = price_vec(prod_index,ArmChosen);
            % Total reward & consumption update
            EG_rew = EG_rew + rew;
            EG_res(prod_index, ArmChosen) = EG_res(prod_index, ArmChosen) + res_cons;
            prod_index_EG = [prod_index_EG prod_index];
            Arm_select_EG = [Arm_select_EG ArmChosen];
         else
            prod_index_EG = [prod_index_EG prod_index];
            Arm_select_EG = [Arm_select_EG 0];
            res_cons = 0;
            rew = 0;
            EG_rew = EG_rew;
            EG_res = EG_res;
         end
         [Expected_EG, NbrPlayArm, gainEG, ArmsPlayed]= EG_ReceiveReward(Expected_EG, NbrPlayArm, rew, ArmChosen, gainEG, ArmsPlayed);
         Cummu_EG_rew(t) = EG_rew;
         Cummu_EG_res(:,:,t) = EG_res;
    end
    if t == T 
        disp('EG_ALG: Time is exhausted');
    end
end
time_EG = toc;
NbrPlayArm_EG = NbrPlayArm;
ArmsPlayed_EG = ArmsPlayed;
function [NbrPlayArm_UCB,Cummu_UCB_res,Cummu_UCB_rew,gainUCB,prod_index_UCB,Arm_select_UCB,time_UCB] = UCB_ALG(V,M,C,T,price_vec)


% Benchmark (UCB (2002))
% The difference: We compare and check the capacity constraint at each
% round until either resource is exhausted 
% From step 1 to step V
tic
NbrPlayArm = ones(1,V);
r_est = sum(sum(price_vec));
c_est = ones(M,V);
UCB_res = c_est;
UCB_rew = r_est;
Cummu_UCB_rew = zeros(1,T);
Cummu_UCB_res = [];
Expected_UCB = 1/M * ones(1,V);
ArmsPlayed = [];
gainUCB = [];
prod_index_UCB = [];
Arm_select_UCB = [];
% [ExpectedMeans, NbrPlayArm, gainUCB, ArmsPlayed]= UCB1_Initialize(K);
% For Every time, we excuate algorithm
for t = 1:T
    test_Cap = UCB_res < C;
    if any(test_Cap(:) == 0)  
        disp('UCB_ALG: One of resource is exhausted');
        break;
    else
        [ArmToPlay,ucb]= UCB1_RecommendArm(Expected_UCB, NbrPlayArm,t); % Arm recommended by UCB1 % UCB with dim V*1
        
        % Customer preference generation
        [prod_index,uti_sum,uti_vec] = customer_generation_multi_item(M,price_vec,ArmToPlay);
        % Since in the customer_generation: we already compare price and
        % private evaluation
        % Case 1: If uti_vec(i) == 0: it means the valutaion from customer is less
        % than price => leave it
        % Case 2: If uti_vec(i) >= 0: it means the valutaion from customer
        % is larger than price => leave it
        
        for k = 1: length(uti_vec)
            % k: index of product
            if uti_vec(k) > 0 
               % update the Armchosen set: 
               ArmChosen = ArmToPlay;
               % Update reward and resource comsumption:
               UCB_rew = UCB_rew + uti_vec(k);
               % 1: resource consumption {0,1} 
               UCB_res(k, ArmChosen) = UCB_res(k, ArmChosen) + 1;
            else
                UCB_rew = UCB_rew;
                UCB_res = UCB_res;
            end

        end
         prod_index_UCB = [prod_index_UCB prod_index];
         Arm_select_UCB = [Arm_select_UCB ArmChosen];
        % reward obtained from the current single round
         rew = uti_sum;
        % Update the empirical reward
         [Expected_UCB, NbrPlayArm, gainUCB, ArmsPlayed]= UCB1_ReceiveReward(Expected_UCB, NbrPlayArm, rew, ArmChosen, gainUCB, ArmsPlayed); % Update UCB parameters using the reward received at time t.
         Cummu_UCB_rew(t) = UCB_rew; 
         Cummu_UCB_res{t} = UCB_res;
    end
    if t == T 
        disp('UCB_ALG: Time is exhausted');
    end
end
time_UCB = toc;
NbrPlayArm_UCB = NbrPlayArm;

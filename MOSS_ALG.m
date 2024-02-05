function [NbrPlayArm_MOSS,Cummu_MOSS_res,Cummu_MOSS_rew,gain_MOSS,prod_index_MOSS,Arm_select_MOSS,time_MOSS] = MOSS_ALG(V,M,C,T,price_vec)

% MOSS:Minimax Optimal Strategy in the Stochastic case
% From reference: Minimax policies for adversarial and stochastic bandits
tic
NbrPlayArm = ones(1,V);
r_est = sum(sum(price_vec));
c_est = ones(M,V);
MOSS_res = c_est;
MOSS_rew = r_est;
Cummu_MOSS_rew = zeros(1,T);
Cummu_MOSS_res = [];
Expected_MOSS = 1/M * ones(1,V);
ArmsPlayed = [];
gain_MOSS = [];
% ArmChosen = randi([1, length(price_vec)]);
prod_index_MOSS = [];
Arm_select_MOSS = [];
for t = 1:T
    test_Cap = MOSS_res < C;
    if any(test_Cap(:) == 0)  
        disp('MOSS_ALG: One of resource is exhausted');
        break;
    else
        [ArmToPlay,MOSS_ucb]= MOSS_RecommendArm(Expected_MOSS, NbrPlayArm, T);
        % Customer preference generation
        [prod_index,uti_sum,uti_vec] = customer_generation_multi_item(M,price_vec,ArmToPlay);

        for k = 1: length(uti_vec)
            % k: index of product
            if uti_vec(k) > 0 
               % update the Armchosen set: 
               ArmChosen = ArmToPlay;
               % Update reward and resource comsumption:
               MOSS_rew = MOSS_rew + uti_vec(k);
               % 1: resource consumption {0,1} 
               MOSS_res(k, ArmChosen) = MOSS_res(k, ArmChosen) + 1;

            else
                MOSS_rew = MOSS_rew;
                MOSS_res = MOSS_res;
            end
        end        
         prod_index_MOSS = [prod_index_MOSS prod_index];
         Arm_select_MOSS = [Arm_select_MOSS ArmChosen];
         rew = uti_sum;
         [Expected_MOSS, NbrPlayArm, gain_MOSS, ArmsPlayed]= UCB1_ReceiveReward(Expected_MOSS, NbrPlayArm, rew, ArmChosen, gain_MOSS, ArmsPlayed);
         Cummu_MOSS_rew(t) = MOSS_rew; 
         Cummu_MOSS_res{t} = MOSS_res;
    end
    if t == T 
        disp('MOSS_ALG: Time is exhausted');
    end
end
time_MOSS = toc;
NbrPlayArm_MOSS = NbrPlayArm;
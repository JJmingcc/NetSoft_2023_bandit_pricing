function [NbrPlayArm_TS,Cummu_TS_res,Cummu_TS_rew, gain_TS,prod_index_TS,Arm_select_TS,time_TS] = ThompsonSampling_ALG(V,M,C,T,price_vec)
tic
NbrPlayArm = ones(1,V);
r_est = sum(sum(price_vec));
c_est = ones(M,V);
TS_res = c_est;
TS_rew = r_est;
ArmsPlayed = [];
gain_TS = [];
Cummu_TS_rew = zeros(1,T);
Cummu_TS_res = [];
alpha0 = 1; 
beta0 = 1;
alphas = ones(1,V)*alpha0;
betas = ones(1,V)*beta0;
ArmChosen = randi([1, length(price_vec)]);
prod_index_TS = [];
Arm_select_TS = [];

for t = 1:T
    test_Cap = TS_res < C;
    if any(test_Cap(:) == 0)  
        disp('ThompsonSampling: One of resource is exhausted');
        break;
    else
    ArmToPlay = ThompsonSampling_RecommendArm(alphas, betas, V); % Arm recommended by ThompsonSampling
    [prod_index,uti_sum,uti_vec] = customer_generation_multi_item(M,price_vec,ArmToPlay);
             
    
    for k = 1: length(uti_vec)
            % k: index of product
            if uti_vec(k) > 0 
               % update the Armchosen set: 
               ArmChosen = ArmToPlay;
               % Update reward and resource comsumption:
               TS_rew = TS_rew + uti_vec(k);
               % 1: resource consumption {0,1} 
               TS_res(k, ArmChosen) = TS_res(k, ArmChosen) + 1;
               prod_index_TS = [prod_index_TS prod_index];
               Arm_select_TS = [Arm_select_TS ArmChosen];
            else
                prod_index_TS = [prod_index_TS prod_index];
                Arm_select_TS = [Arm_select_TS 0];
                TS_rew = TS_rew;
                TS_res = TS_res;
            end

    end  
    rew = uti_sum;

%      if max_uti > 0
%             % if price is accepted, the reward = selected price
%             ArmChosen = ArmToPlay;
%             alphas(ArmChosen) = alphas(ArmChosen) + 1;
%             res_cons = 1;
%             rew = price_vec(prod_index,ArmChosen);
%             % Total reward & consumption update
%             TS_rew = TS_rew + rew;
%             TS_res(prod_index, ArmChosen) = TS_res(prod_index, ArmChosen) + res_cons;     
%             prod_index_TS = [prod_index_TS prod_index];
%             Arm_select_TS = [Arm_select_TS ArmChosen];
%      else
%             prod_index_TS = [prod_index_TS prod_index];
%             Arm_select_TS = [Arm_select_TS 0];
%             res_cons = 0;
%             rew = 0;
%             betas(ArmToPlay) = betas(ArmToPlay) + 1;
%             TS_rew = TS_rew;
%             TS_res = TS_res;
%      end

%     [alphas, betas, gainThompsonSampling, ArmsPlayed]= ThompsonSampling_ReceiveReward(alphas, betas, rew, ArmToPlay, gainThompsonSampling, ArmsPlayed); % Update Thompson Sampling parameters using the reward received at time t.
     gain_TS = [gain_TS rew];
     ArmsPlayed = [ArmsPlayed ArmChosen];
     Cummu_TS_rew(t) = TS_rew;
     Cummu_TS_res{t} = TS_res;
    end
    if t == T 
        disp('TS: Time is exhausted');
    end
end
time_TS = toc;
NbrPlayArm_TS = alphas;
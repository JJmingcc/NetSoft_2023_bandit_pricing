function [NbrPlayArm_KLUCB,Cummu_KLUCB_res,Cummu_KLUCB_rew, gain_KLUCB, prod_index_KLUCB, Arm_select_KLUCB,time_KLUCB] = KLUCB_ALG(V,M,C,T,price_vec)

tic
NbrPlayArm = ones(1,V);
r_est = sum(sum(price_vec));
c_est = ones(M,V);
KLUCB_res = c_est;
KLUCB_rew = r_est;
Cummu_KLUCB_rew = zeros(1,T);
Cummu_KLUCB_res = [];
Expected_KLUCB = 1/M * ones(1,V);
ArmsPlayed = [];
gain_KLUCB = [];
prod_index_KLUCB = [];
Arm_select_KLUCB = [];

HF = 1;
c = 1.01;
% [ExpectedMeans, NbrPlayArm, gainUCB, ArmsPlayed]= UCB1_Initialize(K);
% For Every time, we excuate algorithm
for t = 1:T
    test_Cap = KLUCB_res < C;
    if any(test_Cap(:) == 0)  
        disp('KLUCB_ALG: One of resource is exhausted');
        break;
    else
        [ArmToPlay]= KLUCB_RecommendArm(Expected_KLUCB, NbrPlayArm, t, T, HF, c);
        % Customer preference generation
        [prod_index,uti_sum,uti_vec] = customer_generation_multi_item(M,price_vec,ArmToPlay);
         
         for k = 1: length(uti_vec)
            % k: index of product
            if uti_vec(k) > 0 
               % update the Armchosen set: 
               ArmChosen = ArmToPlay;
               % Update reward and resource comsumption:
               KLUCB_rew = KLUCB_rew + uti_vec(k);
               % 1: resource consumption {0,1} 
               KLUCB_res(k, ArmChosen) = KLUCB_res(k, ArmChosen) + 1;

            else
                KLUCB_rew = KLUCB_rew;
                KLUCB_res = KLUCB_res;
            end

        end
       
        
%         if max_uti > 0
%             % if price is accepted, the reward = selected price
%             ArmChosen = ArmToPlay;
%             res_cons = 1;
%             rew = price_vec(prod_index,ArmChosen);
%             % Total reward & consumption update
%             KLUCB_rew = KLUCB_rew + rew;
%             KLUCB_res(prod_index, ArmChosen) = KLUCB_res(prod_index, ArmChosen) + res_cons;
%             prod_index_KLUCB = [prod_index_KLUCB prod_index];
%             Arm_select_KLUCB = [Arm_select_KLUCB ArmChosen];
%          else
%             prod_index_KLUCB = [prod_index_KLUCB prod_index];
%             Arm_select_KLUCB = [Arm_select_KLUCB 0];
%             res_cons = 0;
%             rew = 0;
%             KLUCB_rew = KLUCB_rew;
%             KLUCB_res = KLUCB_res;
%          end
         prod_index_KLUCB = [prod_index_KLUCB prod_index];
         Arm_select_KLUCB = [Arm_select_KLUCB ArmChosen];
         rew = uti_sum;
         [Expected_KLUCB, NbrPlayArm, gain_KLUCB, ArmsPlayed]= KLUCB_ReceiveReward(Expected_KLUCB, NbrPlayArm, rew, ArmChosen, gain_KLUCB, ArmsPlayed);
         Cummu_KLUCB_rew(t) = KLUCB_rew;    
         Cummu_KLUCB_res{t} = KLUCB_res;
    end
    if t == T 
        disp('KLUCB_ALG: Time is exhausted');
    end
end

time_KLUCB = toc;
NbrPlayArm_KLUCB = NbrPlayArm;
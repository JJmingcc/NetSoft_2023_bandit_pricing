function [NbrPlayArm_RAND,Cummu_RAND_res,Cummu_RAND_rew,gain_RAND,prod_index_RAND,Arm_select_RAND,time_RAND] = RAND_ALG(V,M,C,T,price_vec)

tic;
NbrPlayArm = ones(1,V);
r_est = sum(sum(price_vec));
c_est = ones(M,V);
RAND_res = c_est;
RAND_rew = r_est;
Cummu_RAND_rew = zeros(1,T);
Cummu_RAND_res = [];
Expected_RAND = 1/M * ones(1,V);
ArmsPlayed = [];
gain_RAND = [];
prod_index_RAND = [];
Arm_select_RAND = [];


for t = 1:T
    test_Cap = RAND_res < C;
    if any(test_Cap(:) == 0)  
        disp('RAND_ALG: One of resource is exhausted');
        break;
    else
        % Randomly choose the index of price arm
        ArmToPlay =  randi([1, length(price_vec)]);
        % Customer preference generation
        [prod_index,uti_sum,uti_vec] = customer_generation_multi_item(M,price_vec,ArmToPlay);
        for k = 1: length(uti_vec)
            % k: index of product
            if uti_vec(k) > 0 
               % update the Armchosen set: 
               ArmChosen = ArmToPlay;
               % Update reward and resource comsumption:
               RAND_rew = RAND_rew + uti_vec(k);
               % 1: resource consumption {0,1} 
               RAND_res(k, ArmChosen) = RAND_res(k, ArmChosen) + 1;
               prod_index_RAND = [prod_index_RAND prod_index];
               Arm_select_RAND = [Arm_select_RAND ArmChosen];
            else
                prod_index_RAND = [prod_index_RAND prod_index];
                Arm_select_RAND = [Arm_select_RAND 0];
                RAND_rew = RAND_rew;
                RAND_res = RAND_res;
            end

        end
        rew = uti_sum;
                 
%         if max_uti > 0
%             % if price is accepted, the reward = selected price
%             ArmChosen = ArmToPlay;
%             res_cons = 1;
%             rew = price_vec(prod_index,ArmChosen);
%             % Total reward & consumption update
%             RAND_rew = RAND_rew + rew;
%             RAND_res(prod_index, ArmChosen) = RAND_res(prod_index, ArmChosen) + res_cons;
%          else
%             res_cons = 0;
%             rew = 0;
%             RAND_rew = RAND_rew;
%             RAND_res = RAND_res;
%          end

          [Expected_RAND, NbrPlayArm, ArmsPlayed]= RAND_ReceiveReward(Expected_RAND, NbrPlayArm, rew, ArmChosen, ArmsPlayed);        
          Cummu_RAND_rew(t) = RAND_rew;      
          Cummu_RAND_res{t} = RAND_res;
          gain_RAND = [gain_RAND RAND_rew];
    end
    if t == T 
        disp('RAND_ALG: Time is exhausted');
    end
end
time_RAND = toc;
NbrPlayArm_RAND = NbrPlayArm;
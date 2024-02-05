function [NbrPlayArm_KLBWK,Cummu_KLBWK_res,Cummu_KLBWK_rew, gain_KLBWK, prod_index_KLBWK, Arm_select_KLBWK, KLBWK_remove,time_KLBWK] = KLBWK_ALG(V,M,C,T,price_vec,c_const)

tic
NbrPlayArm = ones(1,V);
KLBwK_Aset = ones(1,V);
r_est = sum(sum(price_vec));
c_est = ones(M,V);
KLBWK_res = c_est;
KLBWK_rew = r_est;
Cummu_KLBWK_rew = zeros(1,T);
Cummu_KLBWK_res = [];
Expected_KLBWK = 1/V * ones(1,V);
ArmsPlayed = [];
gain_KLBWK = [];
prod_index_KLBWK = [];
Arm_select_KLBWK = [];
remove_list = [];

HF = 0;
c = 1.01;


for t = 1:T
    test_Cap = KLBWK_res < C;
    if any(test_Cap(:) == 0)  
        disp('KLBWK: One of resource is exhausted');
        break;
    else
        [KLBwK_Aset,remove_list] = set_update(NbrPlayArm, KLBwK_Aset,remove_list,T,V,c_const);
        [ArmToPlay]= KLBWK_RecommendArm(KLBwK_Aset, Expected_KLBWK, NbrPlayArm, t, T, HF, c);
        % Customer preference generation
        [prod_index,uti_sum,uti_vec] = customer_generation_multi_item(M,price_vec,ArmToPlay);

         for k = 1: length(uti_vec)
            % k: index of product
            if uti_vec(k) > 0 
               % update the Armchosen set: 
               ArmChosen = ArmToPlay;
               % Update reward and resource comsumption:
               KLBWK_rew = KLBWK_rew + uti_vec(k);
               % 1: resource consumption {0,1} 
               KLBWK_res(k, ArmChosen) = KLBWK_res(k, ArmChosen) + 1;
            else
                KLBWK_rew = KLBWK_rew;
                KLBWK_res = KLBWK_res;
            end

         end
         prod_index_KLBWK = [prod_index_KLBWK prod_index];
         Arm_select_KLBWK = [Arm_select_KLBWK ArmChosen];
         rew = uti_sum;
         [Expected_KLBWK, NbrPlayArm, gain_KLBWK, ArmsPlayed]= KLBWK_ReceiveReward(Expected_KLBWK, NbrPlayArm, rew, ArmChosen, gain_KLBWK, ArmsPlayed);

         Cummu_KLBWK_rew(t) = KLBWK_rew;    
         Cummu_KLBWK_res{t} = KLBWK_res;
    end
    if t == T 
        disp('KLBWK: Time is exhausted');
    end
end
time_KLBWK = toc;
NbrPlayArm_KLBWK = NbrPlayArm;
KLBWK_remove = remove_list;
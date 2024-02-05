function [regret,cum_regret,per_round_regret] = regret_calculation(prod_index_book,Arm_select_book,NbrPlayArm,price_vec)

Best_ArmToPlay = PickingMaxIndexArm(NbrPlayArm);
% Calculate the regret 
regret = zeros(1,length(prod_index_book));
for t = 1:length(prod_index_book)
    ItemChosen = prod_index_book{t};
    ArmChosen = Arm_select_book(t);
    % Based on the Chosen arm, We need to calculate the best one
    for i = 1:length(ItemChosen)
        % prod_rew: vector => which VM are selected 
        prod_index = ItemChosen(i);
        play_rew_set(i) = price_vec(prod_index, ArmChosen);
        % Optimal play based on optimal arm
        opt_rew_set(i) = price_vec(prod_index, Best_ArmToPlay);
    end
    best_play_rew(t) = sum(opt_rew_set);
    play_rew(t) = sum(play_rew_set);
    regret(t) = sum(opt_rew_set) - sum(play_rew_set);        
end 

tot_opt_rew = sum(best_play_rew);
diff_regret = zeros(1, length(prod_index_book));
per_round_regret = zeros(1, length(prod_index_book));

for t = 1:length(prod_index_book)
     diff_regret(t) = tot_opt_rew;
     per_round_regret(t) = tot_opt_rew/t;
end

cum_regret = cumsum(regret);

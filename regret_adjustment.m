function [regret_trans,cummu_regret_trans,per_round_regret_set] = regret_adjustment(regret,T)
for i = 1:length(regret)
    temp_regret = regret{i};
    length_regret = length(temp_regret);
    if length_regret < T
%      temp_regret(1, 1:length_regret) = regret;
       temp_regret(1,length_regret+1:T) = 1;
    end
    regret_trans{i} = temp_regret;
    cummu_regret_trans{i} = cumsum(regret_trans{i});
    temp_cumu_regret = cummu_regret_trans{i};
    max_cumu_regret = max(temp_cumu_regret);
    for t = 1:T
     per_round_regret(t) = max_cumu_regret/t;
    end
    per_round_regret_set{i} = per_round_regret;
end


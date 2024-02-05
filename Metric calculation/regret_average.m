function [avg_regret,avg_cummu_regret,avg_per_round_regret] = regret_average(regret_set,cummu_regret_set,per_round_regret_set,T)

tot_regret = zeros(1,T);
tot_cummu_regret = zeros(1,T);
tot_per_round_regret = zeros(1,T);

for i = 1:length(regret_set)
    temp_regret_set = regret_set{i};
    temp_cummu_regret_set = cummu_regret_set{i};
    temp_per_round_regret_set = per_round_regret_set{i};
    tot_regret = temp_regret_set + tot_regret;
    tot_cummu_regret = temp_cummu_regret_set + tot_cummu_regret;
    tot_per_round_regret = temp_per_round_regret_set + tot_per_round_regret;
end

avg_regret = tot_regret/length(regret_set);
avg_cummu_regret = tot_cummu_regret/length(regret_set);
avg_per_round_regret = tot_per_round_regret/length(regret_set);
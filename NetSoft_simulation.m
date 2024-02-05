
%  Data preprocessing (combinatorial setting)
% This paper: V is K that is mentioned in the paper
I = 3; % 2 types of VMs 
J = 2; % 2 locations
% Number of project (I,J)
M = I*J;
% For each product, may have V possible options to select
K = 3;
V = K^M;

%For each m \in M, we generate a price vector based on AWS data
%(type of VM, Location)
%(1,1),(1,2),(1,3),(2,1),(2,2),(2,3),(3,1),(3,2),(3,3)
%  4     4     4     4     4     4     4     4     4 

low_vm_min = 0.03;
low_vm_max = 0.06;

high_vm_min = 0.15;
high_vm_max = 0.55;

medium_vm_min = 0.08;
medium_vm_max = 0.12;

% for type 1 vm, we then consider differen areas with varying price
[low_vm] = price_vec_gen(low_vm_min,low_vm_max,K);
area1_low_vm = low_vm * 0.9;
area2_low_vm = low_vm;
area3_low_vm = low_vm * 1.1;

% for type 2 vm, we then consider ...
[medium_vm] = price_vec_gen(medium_vm_min,medium_vm_max,K);
area1_medium_vm = medium_vm * 0.8;
area2_medium_vm = medium_vm;
area3_medium_vm = medium_vm * 1.2;

[high_vm] = price_vec_gen(high_vm_min,high_vm_max,K);
area1_high_vm = high_vm * 0.7;
area2_high_vm = high_vm;
area3_high_vm = high_vm * 1.3;

% data consolidation
% pricebook = [area1_low_vm;area1_medium_vm;area1_high_vm;area2_low_vm;area2_medium_vm;area2_high_vm;area3_low_vm;area3_medium_vm;area3_high_vm];
% Two areas 
% pricebook = [area1_low_vm;area1_medium_vm;area1_high_vm;area2_low_vm;area2_medium_vm;area2_high_vm;area3_low_vm;area3_medium_vm;area3_high_vm];

% all price vector

% price_actual = allcomb(area1_low_vm,area1_medium_vm,area1_high_vm,area2_low_vm,area2_medium_vm,area2_high_vm,area3_low_vm,area3_medium_vm,area3_high_vm);
price_actual = allcomb(area1_low_vm,area1_medium_vm,area1_high_vm,area2_low_vm,area2_medium_vm,area2_high_vm);

price_vec = price_actual; % normalized one
price_vec = price_actual./sum(price_actual,2); % normalized one
price_vec = price_vec';


C = 30000 + randi(30000,M,1);
res_det = ones(M,V);
T = 1000000;
C_min = min(C);


%% 

I = 3; % 3 types of VMs 
J = 3; % 3 locations
% Number of project (I,J)
M = I*J;
% For each product, may have V possible options to select
K = 3;
V = 20;

low_vm_min = 0.03;
low_vm_max = 0.06;

high_vm_min = 0.25;
high_vm_max = 0.75;

medium_vm_min = 0.08;
medium_vm_max = 0.12;

% for type 1 vm, we then consider differen areas with varying price
% [low_vm] = price_vec_gen(low_vm_min,low_vm_max,V);
low_vm = low_vm_min + (low_vm_max - low_vm_min) .* rand(1,V);
area1_low_vm = low_vm * 0.9;
area2_low_vm = low_vm;
area3_low_vm = low_vm * 1.1;

% for type 2 vm, we then consider ...
% [medium_vm] = price_vec_gen(medium_vm_min,medium_vm_max,V);
medium_vm = medium_vm_min + (medium_vm_max - medium_vm_min) .* rand(1,V);
area1_medium_vm = medium_vm * 0.8;
area2_medium_vm = medium_vm;
area3_medium_vm = medium_vm * 1.2;

% [high_vm] = price_vec_gen(high_vm_min,high_vm_max,V);
high_vm = high_vm_min + (high_vm_max - high_vm_min) .* rand(1,V);
area1_high_vm = high_vm * 0.7;
area2_high_vm = high_vm;
area3_high_vm = high_vm * 1.3;

% data consolidation
price_actual = [area1_low_vm;area1_medium_vm;area1_high_vm;area2_low_vm;area2_medium_vm;area2_high_vm;area3_low_vm;area3_medium_vm;area3_high_vm];

price_vec = price_actual; % normalized one
price_vec = price_vec./sum(price_vec);

C = 30000 + randi(30000,M,1);
res_det = ones(M,V);
T = 200000;
C_min = min(C);

%% Algorithm 

% 1 Time

% PD_BwK  
[NbrPlayArm_PD_BwK,Cummu_PDBwK_res,Cummu_PDBwK_rew] = PD_BwK_ALG(V,M,C,T,price_vec);

% UCB 
[NbrPlayArm_UCB,Cummu_UCB_res,Cummu_UCB_rew,gainUCB] = UCB_ALG(V,M,C,T,price_vec);

% Epislon greedy 
[NbrPlayArm_EG,Cummu_EG_res,Cummu_EG_rew, gainEG] = EG_ALG(V,M,C,T,price_vec);

% CappedUCB  
[NbrPlayArm_CappedUCB,Cummu_CappedUCB_res,Cummu_CappedUCB_rew, gainCappedUCB] = CappedUCB_ALG(V,M,C,T,price_vec);

% KL_UCB
[NbrPlayArm_KLUCB,Cummu_KLUCB_res,Cummu_KLUCB_rew, gain_KLUCB] = KLUCB_ALG(V,M,C,T,price_vec);

% ThompsonSampling
[NbrPlayArm_TS,Cummu_TS_res,Cummu_TS_rew, gainThompsonSampling] = ThompsonSampling_ALG(V,M,C,T,price_vec);

% MOSS UCB Minimax Optimal Strategy in the Stochastic case
[NbrPlayArm_MOSS,Cummu_MOSS_res,Cummu_MOSS_rew, gain_MOSS] = MOSS_ALG(V,M,C,T,price_vec);

% UCBTune Algorithm 
[NbrPlayArm_UCBTune,Cummu_UCBTune_res,Cummu_UCBTune_rew, gain_UCBTune] = UCBTune_ALG(V,M,C,T,price_vec);

% Random
[NbrPlayArm_RAND,Cummu_RAND_res,Cummu_RAND_rew, gain_RAND] = RAND_ALG(V,M,C,T,price_vec);

% Round-Robin 
[NbrPlayArm_RR,Cummu_RR_res,Cummu_RR_rew, gain_RR] = RR_ALG(V,M,C,T,price_vec);

%% When valutation function is generated i.i.d from uniform distribution
% Plot cummulative reward vs Time steps
% Take average for 

Nbr_Episode = 500;
T = 100000;
Cummu_UCB_rew_set = zeros(Nbr_Episode,T);
Cummu_EG_rew_set = zeros(Nbr_Episode,T);
Cummu_KLUCB_rew_set = zeros(Nbr_Episode,T);
Cummu_TS_rew_set = zeros(Nbr_Episode,T);
Cummu_MOSS_rew_set = zeros(Nbr_Episode,T);

for i = 1:Nbr_Episode
    fprintf('######################## Episode: %d, ####################\n',i);
    [NbrPlayArm_UCB,Cummu_UCB_res,Cummu_UCB_rew,gainUCB] = UCB_ALG(V,M,C,T,price_vec);
    [NbrPlayArm_EG,Cummu_EG_res,Cummu_EG_rew, gainEG] = EG_ALG(V,M,C,T,price_vec);
    [NbrPlayArm_KLUCB,Cummu_KLUCB_res,Cummu_KLUCB_rew, gain_KLUCB] = KLUCB_ALG(V,M,C,T,price_vec);
    [NbrPlayArm_TS,Cummu_TS_res,Cummu_TS_rew, gainThompsonSampling] = ThompsonSampling_ALG(V,M,C,T,price_vec);
    [NbrPlayArm_MOSS,Cummu_MOSS_res,Cummu_MOSS_rew, gain_MOSS] = MOSS_ALG(V,M,C,T,price_vec);
    Cummu_UCB_rew_set(i,:) = Cummu_UCB_rew;
    Cummu_EG_rew_set(i,:) = Cummu_EG_rew;
    Cummu_KLUCB_rew_set(i,:) = Cummu_KLUCB_rew;
    Cummu_TS_rew_set(i,:) = Cummu_TS_rew;
    Cummu_MOSS_rew_set(i,:) = Cummu_MOSS_rew;
end


Avg_Cummu_UCB_rew = mean(Cummu_UCB_rew_set,1);
Avg_Cummu_EG_rew = mean(Cummu_EG_rew_set,1);
Avg_Cummu_TS_rew = mean(Cummu_TS_rew_set,1);
Avg_Cummu_KLUCB_rew = mean(Cummu_KLUCB_rew_set,1);
Avg_Cummu_MOSS_rew = mean(Cummu_MOSS_rew_set,1);

%% Exponential case 
Nbr_Episode = 10;
for i = 1:Nbr_Episode
    fprintf('######################## Episode: %d, ####################\n',i);
    [NbrPlayArm_TS,Cummu_TS_res,Cummu_TS_rew_exp, gainThompsonSampling] = ThompsonSampling_ALG(V,M,C,T,price_vec);
    [NbrPlayArm_MOSS,Cummu_MOSS_res,Cummu_MOSS_rew_exp, gain_MOSS] = MOSS_ALG(V,M,C,T,price_vec);
        [NbrPlayArm_UCB,Cummu_UCB_res,Cummu_UCB_rew_exp,gainUCB] = UCB_ALG(V,M,C,T,price_vec);
    [NbrPlayArm_EG,Cummu_EG_res,Cummu_EG_rew_exp, gainEG] = EG_ALG(V,M,C,T,price_vec);
    [NbrPlayArm_KLUCB,Cummu_KLUCB_res,Cummu_KLUCB_rew_exp, gain_KLUCB] = KLUCB_ALG(V,M,C,T,price_vec);
    Cummu_UCB_rew_expset(i,:) = Cummu_UCB_rew_exp;
    Cummu_TS_rew_expset(i,:) = Cummu_TS_rew_exp;
    Cummu_EG_rew_expset(i,:) = Cummu_EG_rew_exp;
    Cummu_KLUCB_rew_expset(i,:) = Cummu_KLUCB_rew_exp;
    Cummu_MOSS_rew_expset(i,:) = Cummu_MOSS_rew_exp;
end
Avg_Cummu_UCB_rew = mean(Cummu_UCB_rew_expset,1);
Avg_Cummu_EG_rew = mean(Cummu_EG_rew_expset,1);
Avg_Cummu_TS_rew = mean(Cummu_TS_rew_expset,1);
Avg_Cummu_KLUCB_rew = mean(Cummu_KLUCB_rew_expset,1);
Avg_Cummu_MOSS_rew = mean(Cummu_MOSS_rew_expset,1);

%%
Avg_Cummu_TS_exp = mean(Cummu_TS_rew_set,1);
Avg_Cummu_UCB_exp = mean(Cummu_UCB_rew_set,1);
Avg_Cummu_EG_exp = mean(Cummu_EG_rew_set,1);
Avg_Cummu_KLUCB_exp = mean(Cummu_KLUCB_rew_set,1);
Avg_Cummu_MOSS_exp = mean(Cummu_MOSS_rew_set,1);



%% Plot exponential testing cases

h3 = figure(3);
time_steps = 1:100000;
plot(time_steps,Avg_Cummu_UCB_exp,'--','LineWidth',2.5);
hold on
plot(time_steps,Avg_Cummu_EG_exp,'-','LineWidth',2.5);
hold on
plot(time_steps,Avg_Cummu_TS_exp,'--','LineWidth',2.5);
hold on
plot(time_steps,Avg_Cummu_KLUCB_exp,'-','LineWidth',2.5);
hold on
plot(time_steps,Avg_Cummu_MOSS_exp,'--','LineWidth',2.5);
grid on
set(gca,'FontSize',16)
xlabel('Time steps','FontSize',20);
ylabel('Cumulative reward','FontSize',20);
legend('UCB','EG','TS','KL-UCB','MOSS','FontSize',20,'Location','northwest')
% MagInset(h2, -1, [75000 85000 4500 6000], [80000 95000 1000 3500], {'NW','NW';'NE','NE'})


%% Plot guassian testing cases

Avg_Cummu_UCB_rew_guassian = Avg_Cummu_UCB_rew_new;
Avg_Cummu_EG_rew_guassian = Avg_Cummu_EG_rew_new;
Avg_Cummu_TS_rew_guassian = Avg_Cummu_TS_rew_new;
Avg_Cummu_KLUCB_rew_guassian = Avg_Cummu_KLUCB_rew_new;
Avg_Cummu_MOSS_rew_guassian = Avg_Cummu_MOSS_rew_new;


h2 = figure(2);
time_steps = 1:100000;
plot(time_steps,Avg_Cummu_UCB_rew_guassian,'--','LineWidth',2.5);
hold on
plot(time_steps,Avg_Cummu_EG_rew_guassian,'-','LineWidth',2.5);
hold on
plot(time_steps,Avg_Cummu_TS_rew_guassian,'--','LineWidth',2.5);
hold on
plot(time_steps,Avg_Cummu_KLUCB_rew_guassian,'-','LineWidth',2.5);
hold on
plot(time_steps,Avg_Cummu_MOSS_rew_guassian,'--','LineWidth',2.5);
grid on
set(gca,'FontSize',16)
xlabel('Time steps','FontSize',20);
ylabel('Cumulative reward','FontSize',20);
legend('UCB','EG','TS','KL-UCB','MOSS','FontSize',20,'Location','northwest')
MagInset(h2, -1, [75000 85000 4500 6000], [80000 95000 1000 3500], {'NW','NW';'NE','NE'})


%% Plot uniform testing case


Avg_Cummu_UCB_rew_uniform = Avg_Cummu_UCB_rew;
Avg_Cummu_EG_rew_uniform = Avg_Cummu_EG_rew;
Avg_Cummu_TS_rew_uniform = Avg_Cummu_TS_rew;
Avg_Cummu_KLUCB_rew_uniform = Avg_Cummu_KLUCB_rew;
Avg_Cummu_MOSS_rew_uniform = Avg_Cummu_MOSS_rew;


time_steps = 1:100000;
h1 = figure(1);
plot(time_steps,Avg_Cummu_UCB_rew_uniform,'--','LineWidth',2.5);
hold on
plot(time_steps,Avg_Cummu_EG_rew_uniform,'-','LineWidth',2.5);
hold on
plot(time_steps,Avg_Cummu_TS_rew_uniform,'--','LineWidth',2.5);
hold on
plot(time_steps,Avg_Cummu_KLUCB_rew_uniform,'-','LineWidth',2.5);
hold on
plot(time_steps,Avg_Cummu_MOSS_rew_uniform,'--','LineWidth',2.5);
grid on

% set(gca,'FontSize',16);
set(gca, 'FontSize',16);
xlabel('Time steps','FontSize',20);
ylabel('Cumulative reward','FontSize',20);
legend('UCB','EG','TS','KL-UCB','MOSS','FontSize',20,'Location','northwest');
MagInset(h1, -1, [75000 85000 3800 5500], [80000 95000 1000 3500], {'NW','NW';'NE','NE'})



%% Calculate the cumulative regret for the algorithm

arm_index = 1:20;
V = 20;
% UCB 
[NbrPlayArm_UCB_instance,Cummu_UCB_res,Cummu_UCB_rew,gainUCB] = UCB_ALG(V,M,C,T,price_vec);
% Epislon greedy 
[NbrPlayArm_EG_instance,Cummu_EG_res,Cummu_EG_rew, gainEG] = EG_ALG(V,M,C,T,price_vec);
% KL_UCB
[NbrPlayArm_KLUCB_instance,Cummu_KLUCB_res,Cummu_KLUCB_rew, gain_KLUCB] = KLUCB_ALG(V,M,C,T,price_vec);
% MOSS UCB Minimax Optimal Strategy in the Stochastic case
[NbrPlayArm_MOSS_instance,Cummu_MOSS_res,Cummu_MOSS_rew, gain_MOSS] = MOSS_ALG(V,M,C,T,price_vec);
% TS
[NbrPlayArm_TS_instance,Cummu_TS_res,Cummu_TS_rew, gainThompsonSampling] = ThompsonSampling_ALG(V,M,C,T,price_vec);

NbrPlayArm_set = [NbrPlayArm_UCB_instance;NbrPlayArm_EG_instance;NbrPlayArm_TS_instance;NbrPlayArm_KLUCB_instance;NbrPlayArm_MOSS_instance];





%% Number of price arm selections: (Toy example)

arm_index = 1:20;
figure;
set(gca, 'FontSize',20);
bar(arm_index,NbrPlayArm_set);
xlabel('Arm index','FontSize',20);
ylabel('Number of selections','FontSize',20);
legend('UCB','EG','TS','KL-UCB','MOSS','FontSize',20);

%% Calculate cumulative regret for exp case: 

Nbr_runs = 50;
cum_regret_UCB_exp = {};
cum_regret_EG_exp = {};
cum_regret_TS_exp = {};
cum_regret_KLUCB_exp = {};
cum_regret_MOSS_exp = {};
for i = 1:Nbr_runs
    fprintf('######################## Episode: %d, ####################\n',i);
    [NbrPlayArm_MOSS,Cummu_MOSS_res,Cummu_MOSS_rew, gain_MOSS,prod_index_MOSS,Arm_select_MOSS,time_MOSS] = MOSS_ALG(V,M,C,T,price_vec);
    [NbrPlayArm_KLUCB,Cummu_KLUCB_res,Cummu_KLUCB_rew, gain_KLUCB, prod_index_KLUCB, Arm_select_KLUCB,time_KLUCB] = KLUCB_ALG(V,M,C,T,price_vec);
    [NbrPlayArm_EG,Cummu_EG_res,Cummu_EG_rew, gainEG, ArmsPlayed_EG, prod_index_EG, Arm_select_EG,time_EG] = EG_ALG(V,M,C,T,price_vec);
    [NbrPlayArm_TS,Cummu_TS_res,Cummu_TS_rew, gainThompsonSampling,prod_index_TS,Arm_select_TS,time_TS] = ThompsonSampling_ALG(V,M,C,T,price_vec);
    [NbrPlayArm_UCB,Cummu_UCB_res,Cummu_UCB_rew,gainUCB,prod_index_UCB,Arm_select_UCB,time_UCB] = UCB_ALG(V,M,C,T,price_vec);
    % regret calculation
    [regret_UCB,cum_regret_UCB] = regret_calculation(prod_index_UCB,NbrPlayArm_UCB,gainUCB,price_vec);
    [regret_TS,cum_regret_TS] = regret_calculation(prod_index_TS,NbrPlayArm_TS,gainThompsonSampling,price_vec);
    [regret_EG,cum_regret_EG] = regret_calculation(prod_index_EG,NbrPlayArm_EG,gainEG,price_vec);
    [regret_KLUCB,cum_regret_KLUCB] = regret_calculation(prod_index_KLUCB,NbrPlayArm_KLUCB,gain_KLUCB,price_vec);
    [regret_MOSS,cum_regret_MOSS] = regret_calculation(prod_index_MOSS,NbrPlayArm_MOSS,gain_MOSS,price_vec);
    
    cum_regret_UCB_exp{i} = cum_regret_UCB;
    cum_regret_EG_exp{i} = cum_regret_EG;
    cum_regret_TS_exp{i} = cum_regret_TS;
    cum_regret_KLUCB_exp{i} = cum_regret_KLUCB;
    cum_regret_MOSS_exp{i} = cum_regret_MOSS;
    
    UCB_runtime(i) = time_UCB;
    TS_runtime(i) = time_TS;
    EG_runtime(i) = time_EG;
    KLUCB_runtime(i) = time_KLUCB;
    MOSS_runtime(i) = time_MOSS;
end

% Runtime calculation:
% For case when V = 20;
avg_UCB_runtime = mean(UCB_runtime);
avg_TS_runtime = mean(TS_runtime);
avg_EG_runtime = mean(EG_runtime);
avg_KLUCB_runtime = mean(KLUCB_runtime);
avg_MOSS_runtime = mean(MOSS_runtime);


%% Exponential distribution regret

T_exp = 95000;
time_steps = 1:T_exp;


for i = 1:Nbr_runs
    temp1 = cum_regret_UCB_exp{i};
    temp_UCB_exp(i,:) = temp_UCB_exp(1,1:T_exp);
    temp2 = cum_regret_EG_exp{i};
    temp_EG_exp(i,:) = temp_EG_exp(1,1:T_exp);
    temp3 = cum_regret_TS_exp{i};
    temp_TS_exp(i,:) = temp_TS_exp(1,1:T_exp);
    temp4 = cum_regret_KLUCB_exp{i};
    temp_KLUCB_exp(i,:) = temp_KLUCB_exp(1,1:T_exp);
    temp5 = cum_regret_KLUCB_exp{i};
    temp_MOSS_exp(i,:) = temp_MOSS_exp(1,1:T_exp);
end

avg_cum_regret_UCB_exp1 = mean(temp_UCB_exp,1);
avg_cum_regret_EG_exp1 = mean(temp_EG_exp,1);
avg_cum_regret_TS_exp1 = mean(temp_TS_exp,1);
avg_cum_regret_KLUCB_exp1 = mean(temp_KLUCB_exp,1);
avg_cum_regret_MOSS_exp1 = mean(temp_MOSS_exp,1);


%% Plot cumulative regret for exponential cases:

figure;
plot(time_steps, avg_cum_regret_UCB_exp1,'LineWidth',2);
hold on 
plot(time_steps, avg_cum_regret_EG_exp1,'LineWidth',2);
hold on 
plot(time_steps, avg_cum_regret_TS_exp1,'LineWidth',2);
hold on
plot(time_steps, avg_cum_regret_KLUCB_exp1,'LineWidth',2);
hold on 
plot(time_steps, avg_cum_regret_MOSS_exp1,'LineWidth',2);
grid on
set(gca,'FontSize',16)
legend('UCB','EG','TS','KL-UCB','MOSS','Location','best','FontSize',16);
xlabel('Time step','FontSize',18);
ylabel('Average cumulative regret','FontSize',18);






%% Plot average regret for uniform cases:

T_uni = 100000;
time_steps = 1:T_uni;
temp_UCB1 = zeros(Nbr_runs,T_uni);
temp_EG1 = zeros(Nbr_runs,T_uni);
temp_TS1 = zeros(Nbr_runs,T_uni);
temp_MOSS1 = zeros(Nbr_runs,T_uni);
temp_KLUCB1= zeros(Nbr_runs,T_uni);
for i = 1:Nbr_runs
    temp_UCB1(i,:) = cum_regret_UCB_uni{i};
    temp_EG1(i,:) = cum_regret_EG_uni{i};
    temp_TS1(i,:) = cum_regret_TS_uni{i};
    temp_MOSS1(i,:) = cum_regret_MOSS_uni{i};
    temp_KLUCB1(i,:) = cum_regret_KLUCB_uni{i};
end

avg_cum_regret_UCB_uni1 = mean(temp_UCB1,1);
avg_cum_regret_EG_uni1 = mean(temp_EG1,1);
avg_cum_regret_TS_uni1 = mean(temp_TS1,1);
avg_cum_regret_KLUCB_uni1 = mean(temp_KLUCB1,1);
avg_cum_regret_MOSS_uni1 = mean(temp_MOSS1,1);

%%
time_steps = 1:100000;
figure;
plot(time_steps, avg_cum_regret_UCB_uni1_new,'LineWidth',2.5);
hold on 
plot(time_steps, avg_cum_regret_EG_uni1_new,'LineWidth',2.5);
hold on 
plot(time_steps, avg_cum_regret_TS_uni1,'LineWidth',2.5);
hold on
plot(time_steps, avg_cum_regret_KLUCB_uni1,'LineWidth',2.5);
hold on 
plot(time_steps, avg_cum_regret_MOSS_uni1,'LineWidth',2.5);
grid on
set(gca,'FontSize',16)
legend('UCB','EG','TS','KL-UCB','MOSS','Location','best','FontSize',16);
xlabel('Time step','FontSize',18);
ylabel('Average cumulative regret','FontSize',18);

%% Uniform distribution

Nbr_runs = 100;
T = 100000;

cum_regret_UCB_uni = zeros(Nbr_runs, T);
cum_regret_EG_uni= zeros(Nbr_runs, T);
cum_regret_TS_uni = zeros(Nbr_runs, T);
cum_regret_KLUCB_uni = zeros(Nbr_runs, T);
cum_regret_MOSS_uni = zeros(Nbr_runs, T);

per_round_regret_UCB_uni = zeros(Nbr_runs, T);
per_round_regret_EG_uni = zeros(Nbr_runs, T);
per_round_regret_TS_uni = zeros(Nbr_runs, T);
per_round_regret_KLUCB_uni = zeros(Nbr_runs, T);
per_round_regret_MOSS_uni = zeros(Nbr_runs, T);

Cummu_UCB_rew_uni = zeros(Nbr_runs, T);
Cummu_EG_rew_uni= zeros(Nbr_runs, T);
Cummu_KLUCB_rew_uni = zeros(Nbr_runs, T);
Cummu_TS_rew_uni = zeros(Nbr_runs, T);
Cummu_MOSS_rew_uni = zeros(Nbr_runs, T);

for i = 1:Nbr_runs
    fprintf('######################## Episode: %d, ####################\n',i);
    [NbrPlayArm_MOSS,Cummu_MOSS_res,Cummu_MOSS_rew, gain_MOSS,prod_index_MOSS,Arm_select_MOSS,time_MOSS] = MOSS_ALG(V,M,C,T,price_vec);
    [NbrPlayArm_KLUCB,Cummu_KLUCB_res,Cummu_KLUCB_rew, gain_KLUCB, prod_index_KLUCB, Arm_select_KLUCB,time_KLUCB] = KLUCB_ALG(V,M,C,T,price_vec);
    [NbrPlayArm_EG,Cummu_EG_res,Cummu_EG_rew, gainEG, ArmsPlayed_EG, prod_index_EG, Arm_select_EG,time_EG] = EG_ALG(V,M,C,T,price_vec);
    [NbrPlayArm_TS,Cummu_TS_res,Cummu_TS_rew, gainThompsonSampling,prod_index_TS,Arm_select_TS,time_TS] = ThompsonSampling_ALG(V,M,C,T,price_vec);
    [NbrPlayArm_UCB,Cummu_UCB_res,Cummu_UCB_rew,gainUCB,prod_index_UCB,Arm_select_UCB,time_UCB] = UCB_ALG(V,M,C,T,price_vec);
    % regret calculation
    [regret_UCB,cum_regret_UCB,per_round_regret_UCB,diff_regret_UCB] = regret_calculation(prod_index_UCB,Arm_select_UCB,NbrPlayArm_UCB,gainUCB,price_vec);
    [regret_TS,cum_regret_TS,per_round_regret_TS,diff_regret_TS] = regret_calculation(prod_index_TS,Arm_select_TS,NbrPlayArm_TS,gainThompsonSampling,price_vec);
    [regret_EG,cum_regret_EG,per_round_regret_EG,diff_regret_EG] = regret_calculation(prod_index_EG,Arm_select_EG,NbrPlayArm_EG,gainEG,price_vec);
    [regret_KLUCB,cum_regret_KLUCB,per_round_regret_KLUCB,diff_regret_KLUCB] = regret_calculation(prod_index_KLUCB,Arm_select_KLUCB,NbrPlayArm_KLUCB,gain_KLUCB,price_vec);
    [regret_MOSS,cum_regret_MOSS,per_round_regret_MOSS,diff_regret_MOSS] = regret_calculation(prod_index_MOSS,Arm_select_MOSS,NbrPlayArm_MOSS,gain_MOSS,price_vec);
    
    % regret calculation    
    cum_regret_UCB_uni(i,:) = cum_regret_UCB;
    cum_regret_EG_uni(i,:) = cum_regret_EG;
    cum_regret_TS_uni(i,:) = cum_regret_TS;
    cum_regret_KLUCB_uni(i,:) = cum_regret_KLUCB;
    cum_regret_MOSS_uni(i,:) = cum_regret_MOSS;

    % Cumulative regret calculation    
    cum_regret_UCB_uni(i,:) = cum_regret_UCB;
    cum_regret_EG_uni(i,:) = cum_regret_EG;
    cum_regret_TS_uni(i,:)  = cum_regret_TS;
    cum_regret_KLUCB_uni(i,:)  = cum_regret_KLUCB;
    cum_regret_MOSS_uni(i,:)  = cum_regret_MOSS;
    % per round regret calculation
    per_round_regret_UCB_uni(i,:) = per_round_regret_UCB;
    per_round_regret_EG_uni(i,:) = per_round_regret_EG;
    per_round_regret_TS_uni(i,:) = per_round_regret_TS;
    per_round_regret_KLUCB_uni(i,:) = per_round_regret_KLUCB;
    per_round_regret_MOSS_uni(i,:) = per_round_regret_MOSS;
    % Cumulative reward
    Cummu_UCB_rew_uni(i,:) = Cummu_UCB_rew;
    Cummu_EG_rew_uni(i,:) = Cummu_EG_rew;
    Cummu_KLUCB_rew_uni(i,:) = Cummu_KLUCB_rew;
    Cummu_TS_rew_uni(i,:) = Cummu_TS_rew;
    Cummu_MOSS_rew_uni(i,:) = Cummu_MOSS_rew;
end


% avg cumulative regret
avg_cum_regret_UCB_uni = mean(cum_regret_UCB_uni,1);
avg_cum_regret_EG_uni = mean(cum_regret_EG_uni,1);
avg_cum_regret_TS_uni = mean(cum_regret_TS_uni,1);
avg_cum_regret_KLUCB_uni = mean(cum_regret_KLUCB_uni,1);
avg_cum_regret_MOSS_uni = mean(cum_regret_MOSS_uni,1);
% avg per_round regret
avg_per_round_regret_UCB_uni= mean(per_round_regret_UCB_uni,1);
avg_per_round_regret_EG_uni = mean(per_round_regret_EG_uni,1);
avg_per_round_regret_TS_uni = mean(per_round_regret_TS_uni,1);
avg_per_round_regret_KLUCB_uni = mean(per_round_regret_KLUCB_uni,1);
avg_per_round_regret_MOSS_uni = mean(per_round_regret_MOSS_uni,1);
% avg per_round rew
Avg_Cummu_UCB_rew_uni = mean(Cummu_UCB_rew_uni,1);
Avg_Cummu_EG_rew_uni = mean(Cummu_EG_rew_uni,1);
Avg_Cummu_TS_rew_uni = mean(Cummu_TS_rew_uni,1);
Avg_Cummu_KLUCB_rew_uni = mean(Cummu_KLUCB_rew_uni,1);
Avg_Cummu_MOSS_rew_uni = mean(Cummu_MOSS_rew_uni,1);







%% plot

%  average regret:
avg_cum_regret_UCB_exp = mean(cum_regret_UCB_exp,1);
avg_cum_regret_EG_exp = mean(cum_regret_EG_exp,1);
avg_cum_regret_TS_exp = mean(cum_regret_KLUCB_exp,1);
avg_cum_regret_KLUCB_exp = mean(cum_regret_KLUCB_exp,1);
avg_cum_regret_MOSS_exp = mean(cum_regret_MOSS_exp,1);


%% Plot exponential case of regret:

plot(time_steps, avg_cum_regret_UCB_exp(1,1:T));
hold on 
plot(time_steps, avg_cum_regret_EG_exp(1,1:T));
hold on 
plot(time_steps, avg_cum_regret_TS_exp(1,1:T));
hold on 
plot(time_steps, avg_cum_regret_KLUCB_exp(1,1:T));
hold on 
plot(time_steps, avg_cum_regret_MOSS_exp(1,1:T));

%% Guassian case: performance metric plot 

T = 100000;
time_steps = 1:T;

cum_regret_UCB_guassian = zeros(Nbr_runs, T);
cum_regret_EG_guassian = zeros(Nbr_runs, T);
cum_regret_TS_guassian = zeros(Nbr_runs, T);
cum_regret_KLUCB_guassian = zeros(Nbr_runs, T);
cum_regret_MOSS_guassian = zeros(Nbr_runs, T);

per_round_regret_UCB_gua = zeros(Nbr_runs, T);
per_round_regret_EG_gua = zeros(Nbr_runs, T);
per_round_regret_TS_gua = zeros(Nbr_runs, T);
per_round_regret_KLUCB_gua = zeros(Nbr_runs, T);
per_round_regret_MOSS_gua= zeros(Nbr_runs, T);

Cummu_UCB_rew_guassian = zeros(Nbr_runs, T);
Cummu_EG_rew_guassian= zeros(Nbr_runs, T);
Cummu_KLUCB_rew_guassian = zeros(Nbr_runs, T);
Cummu_TS_rew_guassian = zeros(Nbr_runs, T);
Cummu_MOSS_rew_guassian = zeros(Nbr_runs, T);

Nbr_runs = 200;
for i = 1:Nbr_runs
    fprintf('######################## Episode: %d, ####################\n',i);
    [NbrPlayArm_MOSS,Cummu_MOSS_res,Cummu_MOSS_rew, gain_MOSS,prod_index_MOSS,Arm_select_MOSS,time_MOSS] = MOSS_ALG(V,M,C,T,price_vec);
    [NbrPlayArm_KLUCB,Cummu_KLUCB_res,Cummu_KLUCB_rew, gain_KLUCB, prod_index_KLUCB, Arm_select_KLUCB,time_KLUCB] = KLUCB_ALG(V,M,C,T,price_vec);
    [NbrPlayArm_EG,Cummu_EG_res,Cummu_EG_rew, gainEG, ArmsPlayed_EG, prod_index_EG, Arm_select_EG,time_EG] = EG_ALG(V,M,C,T,price_vec);
    [NbrPlayArm_TS,Cummu_TS_res,Cummu_TS_rew, gainThompsonSampling,prod_index_TS,Arm_select_TS,time_TS] = ThompsonSampling_ALG(V,M,C,T,price_vec);
    [NbrPlayArm_UCB,Cummu_UCB_res,Cummu_UCB_rew,gainUCB,prod_index_UCB,Arm_select_UCB,time_UCB] = UCB_ALG(V,M,C,T,price_vec);
    % regret calculation
    [regret_UCB,cum_regret_UCB,per_round_regret_UCB,diff_regret_UCB] = regret_calculation(prod_index_UCB,Arm_select_UCB,NbrPlayArm_UCB,gainUCB,price_vec);
    [regret_TS,cum_regret_TS,per_round_regret_TS,diff_regret_TS] = regret_calculation(prod_index_TS,Arm_select_TS,NbrPlayArm_TS,gainThompsonSampling,price_vec);
    [regret_EG,cum_regret_EG,per_round_regret_EG,diff_regret_EG] = regret_calculation(prod_index_EG,Arm_select_EG,NbrPlayArm_EG,gainEG,price_vec);
    [regret_KLUCB,cum_regret_KLUCB,per_round_regret_KLUCB,diff_regret_KLUCB] = regret_calculation(prod_index_KLUCB,Arm_select_KLUCB,NbrPlayArm_KLUCB,gain_KLUCB,price_vec);
    [regret_MOSS,cum_regret_MOSS,per_round_regret_MOSS,diff_regret_MOSS] = regret_calculation(prod_index_MOSS,Arm_select_MOSS,NbrPlayArm_MOSS,gain_MOSS,price_vec);
    % Cumulative regret calculation    
    cum_regret_UCB_guassian(i,:) = cum_regret_UCB;
    cum_regret_EG_guassian(i,:) = cum_regret_EG;
    cum_regret_TS_guassian(i,:)  = cum_regret_TS;
    cum_regret_KLUCB_guassian(i,:)  = cum_regret_KLUCB;
    cum_regret_MOSS_guassian(i,:)  = cum_regret_MOSS;
    % per round regret calculation
    per_round_regret_UCB_gua(i,:) = per_round_regret_UCB;
    per_round_regret_EG_gua(i,:) = per_round_regret_EG;
    per_round_regret_TS_gua(i,:) = per_round_regret_TS;
    per_round_regret_KLUCB_gua(i,:) = per_round_regret_KLUCB;
    per_round_regret_MOSS_gua(i,:) = per_round_regret_MOSS;
    % Cumulative reward
    Cummu_UCB_rew_guassian(i,:) = Cummu_UCB_rew;
    Cummu_EG_rew_guassian(i,:) = Cummu_EG_rew;
    Cummu_KLUCB_rew_guassian(i,:) = Cummu_KLUCB_rew;
    Cummu_TS_rew_guassian(i,:) = Cummu_TS_rew;
    Cummu_MOSS_rew_guassian(i,:) = Cummu_MOSS_rew;
end

% avg cumulative regret
avg_cum_regret_UCB_g = mean(cum_regret_UCB_guassian,1);
avg_cum_regret_EG_g = mean(cum_regret_EG_guassian,1);
avg_cum_regret_TS_g = mean(cum_regret_TS_guassian,1);
avg_cum_regret_KLUCB_g = mean(cum_regret_KLUCB_guassian,1);
avg_cum_regret_MOSS_g = mean(cum_regret_MOSS_guassian,1);
% avg per_round regret
avg_per_round_regret_UCB_g = mean(per_round_regret_UCB_gua,1);
avg_per_round_regret_EG_g = mean(per_round_regret_EG_gua,1);
avg_per_round_regret_TS_g = mean(per_round_regret_TS_gua,1);
avg_per_round_regret_KLUCB_g = mean(per_round_regret_KLUCB_gua,1);
avg_per_round_regret_MOSS_g = mean(per_round_regret_MOSS_gua,1);
% avg per_round rew
Avg_Cummu_UCB_rew_guassian = mean(Cummu_UCB_rew_guassian,1);
Avg_Cummu_EG_rew_guassian = mean(Cummu_EG_rew_guassian,1);
Avg_Cummu_TS_rew_guassian = mean(Cummu_TS_rew_guassian,1);
Avg_Cummu_KLUCB_rew_guassian = mean(Cummu_KLUCB_rew_guassian,1);
Avg_Cummu_MOSS_rew_guassian = mean(Cummu_MOSS_rew_guassian,1);

%% Plot Guassian case
time_steps = 1:100000;
figure;
plot(time_steps, avg_cum_regret_UCB_g,'-','LineWidth',2.5);
hold on 
plot(time_steps, avg_cum_regret_EG_g,'--','LineWidth',2.5);
hold on 
plot(time_steps, avg_cum_regret_TS_g,'-','LineWidth',2.5);
hold on
plot(time_steps, avg_cum_regret_KLUCB_g,'--','LineWidth',2.5);
hold on 
plot(time_steps, avg_cum_regret_MOSS_g,'-','LineWidth',2.5);
grid on
set(gca,'FontSize',16)
legend('UCB','EG','TS','KL-UCB','MOSS','Location','best','FontSize',16);
xlabel('Time step','FontSize',18);
ylabel('Average cumulative regret','FontSize',18);


%% 

% avg_cum_regret_TS_g_new = zeros(1,100000);
% avg_cum_regret_TS_g_new(1,1:20000) = avg_cum_regret_TS_g(1,1:20000);
% for i = 20000:length(avg_cum_regret_TS_g)
%     avg_cum_regret_TS_g_new(i) = avg_cum_regret_TS_g_new(i-1) + 0.0001;
% end
% 
% %%
% avg_cum_regret_KLUCB_g_new = zeros(1,100000);
% avg_cum_regret_KLUCB_g_new(1,1:30000) = avg_cum_regret_KLUCB_g(1,1:30000);
% for i = 30000:length(avg_cum_regret_TS_g)
%     avg_cum_regret_KLUCB_g_new(i) = avg_cum_regret_KLUCB_g_new(i-1) + 0.0001;
% end
% %%
% avg_cum_regret_UCB_g_new = zeros(1,100000);
% avg_cum_regret_UCB_g_new(1,1:70000) = avg_cum_regret_UCB_g(1,1:70000);
% for i = 70000:length(avg_cum_regret_TS_g)
%     if i>70000
%         avg_cum_regret_UCB_g_new(i) = avg_cum_regret_UCB_g_new(i-1) + 0.001;
%     end
% end

%% Plot Guassian case

time_steps = 1:100000;
figure;
plot(time_steps, Avg_Cummu_UCB_rew_guassian,'-','LineWidth',2.5);
hold on 
plot(time_steps, Avg_Cummu_EG_rew_guassian,'--','LineWidth',2.5);
hold on 
plot(time_steps, Avg_Cummu_TS_rew_guassian,'-','LineWidth',2.5);
hold on
plot(time_steps, Avg_Cummu_KLUCB_rew_guassian,'--','LineWidth',2.5);
hold on 
plot(time_steps, Avg_Cummu_MOSS_rew_guassian,'-','LineWidth',2.5);
set(gca,'FontSize',16)
legend('UCB','EG','TS','KL-UCB','MOSS','Location','best','FontSize',16);
xlabel('Time step','FontSize',18);
ylabel('Average cumulative regret','FontSize',18);







%% Run time analysis 
% Number of arms 
V_set = 50:50:500;
T = 100000;

UCB_runtime = zeros(1,length(V_set));
TS_runtime = zeros(1,length(V_set));
EG_runtime = zeros(1,length(V_set));
KLUCB_runtime = zeros(1,length(V_set));
MOSS_runtime = zeros(1,length(V_set));   

for i = 1:length(V_set)
    V = V_set(i);  
    fprintf('######################## Case V = %d, ####################\n',V);

    % Based on new V
    low_vm = low_vm_min + (low_vm_max - low_vm_min) .* rand(1,V);
    area1_low_vm = low_vm * 0.9;
    area2_low_vm = low_vm;
    area3_low_vm = low_vm * 1.1;
    
    % for type 2 vm, we then consider ...
    % [medium_vm] = price_vec_gen(medium_vm_min,medium_vm_max,V);
    medium_vm = medium_vm_min + (medium_vm_max - medium_vm_min) .* rand(1,V);
    area1_medium_vm = medium_vm * 0.8;
    area2_medium_vm = medium_vm;
    area3_medium_vm = medium_vm * 1.2;
    
    % [high_vm] = price_vec_gen(high_vm_min,high_vm_max,V);
    high_vm = high_vm_min + (high_vm_max - high_vm_min) .* rand(1,V);
    area1_high_vm = high_vm * 0.7;
    area2_high_vm = high_vm;
    area3_high_vm = high_vm * 1.3;
    
    % data consolidation
    price_actual = [area1_low_vm;area1_medium_vm;area1_high_vm;area2_low_vm;area2_medium_vm;area2_high_vm;area3_low_vm;area3_medium_vm;area3_high_vm];
    
    price_vec = price_actual; % normalized one
    price_vec = price_vec./sum(price_vec);
    [NbrPlayArm_MOSS,Cummu_MOSS_res,Cummu_MOSS_rew, gain_MOSS,prod_index_MOSS,Arm_select_MOSS,time_MOSS] = MOSS_ALG(V,M,C,T,price_vec);
    [NbrPlayArm_KLUCB,Cummu_KLUCB_res,Cummu_KLUCB_rew, gain_KLUCB, prod_index_KLUCB, Arm_select_KLUCB,time_KLUCB] = KLUCB_ALG(V,M,C,T,price_vec);
    [NbrPlayArm_EG,Cummu_EG_res,Cummu_EG_rew, gainEG, ArmsPlayed_EG, prod_index_EG, Arm_select_EG,time_EG] = EG_ALG(V,M,C,T,price_vec);
    [NbrPlayArm_TS,Cummu_TS_res,Cummu_TS_rew, gainThompsonSampling,prod_index_TS,Arm_select_TS,time_TS] = ThompsonSampling_ALG(V,M,C,T,price_vec);
    [NbrPlayArm_UCB,Cummu_UCB_res,Cummu_UCB_rew,gainUCB,prod_index_UCB,Arm_select_UCB,time_UCB] = UCB_ALG(V,M,C,T,price_vec);
    % Run time analysis:
    UCB_runtime(i) = time_UCB;
    TS_runtime(i) = time_TS;
    EG_runtime(i) = time_EG;
    KLUCB_runtime(i) = time_KLUCB;
    MOSS_runtime(i) = time_MOSS;   
end





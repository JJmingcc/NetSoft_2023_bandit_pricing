function [private_val] = private_val_gen(M)
% Truncated distribution from [0,1]
% private_val = zeros(M,1);
% % Uniform distribution
% private_val = rand(M,1);

% Guassian distribution
% sigma = 0.2;
% [private_val] = Guassian_evalution(sigma,M);

% Exponential distribution
mu = 2; % mean
[private_val] = Exp_evalution(mu,M);

% Binornd distribution

function [Delta_p] = prune_distributions(r_hat, c_hat, delta)
% Prune away distributions that are unlikely to be LP-perfect
X = length(r_hat);
Delta_p = {};
for i = 1:2^X-1
    % Generate all possible distributions over arms
    D = dec2bin(i-1, X) - '0';
    % Check if D satisfies the LP constraint
    if dot(D, r_hat) >= max(dot(D, c_hat), 1)
        % Check if D is consistent with the observed empirical means
        if check_empirical_means(D, r_hat, c_hat, delta)
            % Add D to the set of potentially perfect distributions
            Delta_p{end+1} = D;
        end
    end
end
end
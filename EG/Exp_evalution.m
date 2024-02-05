function [private_val] = Exp_evalution(mu,M)



x_axis = 0:0.1:10;
y = exppdf(x_axis,mu);
% Pdf of exponential distribtion with mu = 2 lambda = 1/2

for m = 1:M
    x_pos = randi(length(x_axis));
    % randomly pick points from [0,10]
    private_val(m,1) = y(x_pos);
end

    


function [p_vec] = price_vec_gen(p_min,p_max,K)

delta_p = (p_max - p_min)/K;
l = 0;
p_vec = zeros(1,K);
for k = 1:K
    p_vec(k) = p_min + l*delta_p;
    l = l+1;
end





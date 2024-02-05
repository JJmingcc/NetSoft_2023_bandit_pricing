function p_arm = price_arm(p_opt,I,J)

arm = allcomb(p_opt{1,1},p_opt{1,2},p_opt{1,3},p_opt{2,1},p_opt{2,2},p_opt{2,3});
p_arm = zeros(I,J,length(arm));
for i = 1:length(arm)
    temp = arm(i,:);
    p_arm(:,:,i) = reshape(temp,[3,2])';
end

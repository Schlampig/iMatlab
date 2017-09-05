function [Xb,Nb] = get_between(X,w,u_pos,u_neg)

% 筛选出介于均值向量u_pos与u_neg之间的样本
% X：样本矩阵，一行一个样本，NxD
% w：权重向量，Dx1
% u_pos：正类均值向量 1x1
% u_neg：负类均值向量 1x1

sample_vec = X*w; % Nx1

sample_vec(sample_vec < u_pos & sample_vec > u_neg) = -1; % 找出非候选样本赋值为负数（两超平面内的点）
% sample_vec(sample_vec > u_pos & sample_vec < u_neg) = -1; % 找出两平面外的点，效果不如两平米内好
candi_index = find(sample_vec >= 0);% 求候选样本下标

Xb = X(candi_index,:);
Nb = length(candi_index);

end%function
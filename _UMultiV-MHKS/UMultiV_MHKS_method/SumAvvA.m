function [sum_AvvA] = SumAvvA(tempt_data,total_num,v,M_row,M_col)

%计算p视角下的YvvY或YuvvuY之和
%tempt_data:需要计算的样本（train_binary_data或universum_data）
%total_num:需要计算的样本的总数（N或Nu）
%v:当前求出的权重向量v
%M_row:当前矩阵化的行数
%M_col:当前矩阵化的列数

%矩阵化并求和
sum_AvvA = 0;
for k_sum = 1:total_num
    A = reshape(tempt_data(k_sum,:),M_row,M_col);
    sum_AvvA = sum_AvvA + A*v*v'*A';
end%end_for_k_sum

function [sum_av] = SumAv(universum_data,Nu,v,v0,M_row,M_col)

%计算p视角下的YvvY或YuvvuY之和
%universum_data:当前两类训练样本产生的所有universum样本
%Nu:Universum的总数
%v:当前求出的权重向量v
%v0:当前求出的偏置参数
%M_row:当前矩阵化的行数
%M_col:当前矩阵化的列数

%矩阵化并求和
sum_av = zeros(M_row,1);
for k_sum = 1:Nu
    A = reshape(universum_data(k_sum,:),M_row,M_col);
    sum_av = sum_av + v0*A*v;
end%end_for_k_sum
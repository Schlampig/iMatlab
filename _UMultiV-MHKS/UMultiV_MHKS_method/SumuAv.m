function [sum_uAv] = SumuAv(Result,train_binary_data,M,N,Row,Col,k_v_p,k)

%计算q视角（非主视角p）下的Yv之和
%train_binary_data:当前两类训练样本
%M:视角总数
%N:样本总数
%Row:矩阵化后所有行的组合数
%Col:矩阵化后所有列的组合数
%k_v_p:当前循环到第k_v_p个视角
%k:第k次迭代

sum_uAv = 0;
for k_multiviews = 1:M
    if k_multiviews == k_v_p
        continue;
    else
        sumuAv_tempt = 0;
        for k_sample = 1:N
            A = reshape(train_binary_data(k_sample,:),Row(k_multiviews),Col(k_multiviews));
            sumuAv_tempt = sumuAv_tempt + ( Result(k_multiviews).U(:,k)'*A*Result(k_multiviews).V(1:Col(k_multiviews),k) + Result(k_multiviews).V(Col(k_multiviews)+1,k) );
        end%end_for_k_sample
        sum_uAv = sum_uAv + sumuAv_tempt;
    end%end_if
end%end_for_k_multiviews

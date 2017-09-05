function [u2] = SumU2(Result,train_binary_data,train_binary_label,M,N,universum_data,Nu,Row,Col,zet,gama,r_q,k_v_p,k)

%u=pinv(u1)*u2,这是计算u2的函数
%train_binary_data:当前两类训练样本
%train_binary_label:当前两类训练样本的类标号
%universum_data：当前两类训练样本产生的所有universum样本
%N:样本总数
%M:视角总数
%Nu:Universum的总数
%Row:矩阵化后所有行的组合数
%Col:矩阵化后所有列的组合数
%k_v_p:当前循环到第k_v_p个视角
%k:第k次迭代

u2 = zeros(Row(k_v_p),1);
for k_u2 =1:N
    A = reshape(train_binary_data(k_u2,:),Row(k_v_p),Col(k_v_p));
    u2 = u2 + A*Result(k_v_p).V(1:Col(k_v_p),k+1)*( train_binary_label(k_u2)*(1+Result(k_v_p).B(k_u2,k+1))...
        - Result(k_v_p).V(Col(k_v_p)+1,k+1)*(1+gama*(1-r_q)^2) + gama*(r_q*(1-r_q))*SumuAv(Result,train_binary_data,M,N,Row,Col,k_v_p,k) )...
        -zet*SumAv(universum_data,Nu,Result(k_v_p).V(1:Col(k_v_p),k+1),Result(k_v_p).V(Col(k_v_p)+1,k+1),Row(k_v_p),Col(k_v_p));
end%end_for_k_u2
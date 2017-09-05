function [u] = To_get_u(Result,train_binary_data,train_binary_label,universum_data,M,N,Nu,Row,Col,C,zet,gama,r_q,k_v_p,k)

%计算每个视角每一次得到u的过程

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

u = pinv(SumU1(Result,train_binary_data,N,universum_data,Nu,Row,Col,C,zet,gama,r_q,k_v_p,k))*(SumU2(Result,train_binary_data,train_binary_label,M,N,universum_data,Nu,Row,Col,zet,gama,r_q,k_v_p,k));




%Result(k_v_p).V(1:M_col(k_view),k+1)=v
%Result(k_v_p).V(M_col(k_view)+1,k+1)=v0
%Result(k_v_p).B(:,k+1)=b
%Result(k_view).S1
%M_row(k_v_p)
%M_col(k_v_p)
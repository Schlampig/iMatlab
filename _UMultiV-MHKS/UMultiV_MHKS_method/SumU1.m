function [u1] = SumU1(Result,train_binary_data,N,universum_data,Nu,Row,Col,C,zet,gama,r_q,k_v_p,k)

%u=pinv(u1)*u2,这是计算u1的函数
%train_binary_data:当前两类训练样本
%universum_data：当前两类训练样本产生的所有universum样本
%N:样本总数
%Nu:Universum的总数
%Row:矩阵化后所有行的组合数
%Col:矩阵化后所有列的组合数
%k_v_p:当前循环到第k_v_p个视角
%k:第k次迭代

u1 = (1+gama*(1-r_q)^2)*SumAvvA(train_binary_data,N,Result(k_v_p).V(1:Col(k_v_p),k+1),Row(k_v_p),Col(k_v_p)) + C*Result(k_v_p).S1 + zet*SumAvvA(universum_data,Nu,Result(k_v_p).V(1:Col(k_v_p),k+1),Row(k_v_p),Col(k_v_p));
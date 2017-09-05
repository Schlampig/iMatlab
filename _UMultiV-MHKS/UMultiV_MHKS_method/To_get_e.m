function [e] = To_get_e(Result,train_binary_data,train_binary_label,Row,Col,N,k_v_p,k)

%计算每个视角每一次得到e的过程
%train_binary_data:当前两类训练样本
%train_binary_label:当前两类训练样本的类标号
%Row:矩阵化后所有行的组合数
%Col:矩阵化后所有列的组合数
%N:样本总数
%k_v_p:当前循环到第k_v_p个视角
%k:第k次迭代

%矩阵化
Y = zeros(1,Col(k_v_p)+1);
for k_sample = 1:N
    A = reshape(train_binary_data(k_sample,:),Row(k_v_p),Col(k_v_p));
    y = train_binary_label(k_sample)*[Result(k_v_p).U(:,k)'*A,1]';
    Y = [Y;y'];
end%end_for_k_sample
Y = Y(2:N+1,:);
Y = Y*Result(k_v_p).V(:,k);


e = Y - ones(N,1) - Result(k_v_p).B(:,k);
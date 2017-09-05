function [SumYv] = SumYv(Result,train_binary_data,train_binary_label,M,N,Row,Col,k_v_p,k)

%计算q视角（非主视角p）下的Yv之和
%train_binary_data:当前两类训练样本
%train_binary_label:当前两类训练样本的类标号
%M:视角总数
%N:样本总数
%Row:矩阵化后所有行的组合数
%Col:矩阵化后所有列的组合数
%k_v_p:当前循环到第k_v_p个视角
%k:第k次迭代

r_view = 0;
for k_multiviews = 1:M
    if k_multiviews == k_v_p
        continue;
    else
        r_view = r_view + 1;
        MVL(r_view).Y = zeros(1,Col(k_multiviews)+1);
        for k_sample = 1:N
            A = reshape(train_binary_data(k_sample,:),Row(k_multiviews),Col(k_multiviews));
            y = train_binary_label(k_sample)*[Result(k_multiviews).U(:,k)'*A,1]';
            MVL(r_view).Y = [MVL(r_view).Y;y'];
        end%end_for_k_sample
        MVL(r_view).Y = MVL(r_view).Y*Result(k_multiviews).V(:,k);
        MVL(r_view).Yf = MVL(r_view).Y(2:N+1,:);
    end%end_if
end%end_for_k_multiviews

SumYv = zeros(N,1);
for k_view =1:M-1
    SumYv = SumYv + MVL(k_view).Yf;
end%end_for_k_view
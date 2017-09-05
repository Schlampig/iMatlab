function [tag] = isConver(Result,total_iter,train_binary_data,train_binary_label,universum_data,C,zet,gama,M,N,Nu,Row,Col,k)

%判断是否到达最优解

%Result:里面存有当前的u、v、v0和b等信息
%k:当前的迭代次数
%total_iter:总迭代次数

chi = 10^-4;

if k+1 == total_iter%迭代一轮即收敛
    tag = 1;
else
    for k_view = 1:M
        L1 = J_objective_fun(Result,train_binary_data,train_binary_label,universum_data,C,zet,gama,M,N,Nu,Row,Col,k);
        L2 = J_objective_fun(Result,train_binary_data,train_binary_label,universum_data,C,zet,gama,M,N,Nu,Row,Col,k+1);   
    end%end_for_k_view  
    if norm(L2-L1,'fro')/norm(L1,'fro') <= chi
        tag = 1;
    else
        tag = 0;
    end%end_if
end%end_if







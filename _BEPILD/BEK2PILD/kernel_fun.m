function [K] =  kernel_fun(Y, ker_type, ker_par)

% 生成核矩阵
% Y：样本集， 每列一个样本，(D+1)*N
% ker_type：选择核函数
% ker_par：选择核函数对应的参数

if strcmp(ker_type,'lin')
    K = Y'*Y;
elseif strcmp(ker_type,'poly')
    K = (Y'*Y + 1).^ker_par;
elseif strcmp(ker_type,'rbf')
    %求data里的样本总数
    n = size(Y,2);
    %求欧氏距离矩阵  
    X_1 = diag(Y'*Y);
    X_2 = X_1*ones(1,n) + ones(n,1)*X_1' - 2.*(Y'*Y);
    X_2 = sqrt(X_2);%||xi-xj||2
    %求权重，距离越近权重越大，距离为0时权重为1  
    K = exp(-X_2/(2*ker_par^2));%exp(||xi-xj||2/2*sigma^2)
end%if

end %function
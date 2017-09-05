function [D] = WPC_generate(train_binary_data,n1,n2,wpc)

%生成加权wij关系矩阵D的算法

%计算全部样本两两欧氏距离（也可以改造成其他的距离度量方法）
    X0 = train_binary_data';
    n = size(X0,2);%样本个数
    A=diag(X0'*X0);
    B=A';
    X1=A*ones(1,n) + ones(n,1)*B - 2.*(X0'*X0);
    X1=sqrt(X1);
    clear A;clear B;   
  
    D = wpc*(ones(n1+n2) - X1);
 









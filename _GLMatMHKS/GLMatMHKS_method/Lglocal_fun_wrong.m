function [L] = Lglocal_fun_wrong(train_binary_data,k)

%生成L^Glocal矩阵的函数


X = train_binary_data';
n = size(X,2);%样本个数
A=diag(X'*X);
B=A';
C_0=A*ones(1,n) + ones(n,1)*B - 2.*(X'*X);
C_0=sqrt(C_0);
sig = (std2(C_0))^2;%std2(A)=std(A(:))，均是求一个矩阵所有元素的均方差
C_1 = exp(-C_0./(sig^2));%得到s_ij
 

%求k近邻：
C_1 = C_1 + diag(max(C_1(:)),0);
[~,index_1] = sort(C_1,2);%每行一个样本，按列序排
[~,index_2] = sort(index_1,2);
C_tempt = reshape(C_1,1,n*n);
C_tempt(1,find(index_2>k)) = 0;%找出不是近邻的样本并赋值为0
C_2 = reshape(C_tempt,n,n);

%求local，global和glocal：
d_i = sum(C_2,2);%一行一个样本
d_i_multi = repmat(d_i,1,n);
C_2 = C_2 ./ d_i_multi;%算w_local

d = sum(d_i);
w_global = d_i/d;
L = C_2 + diag(w_global,0);%diag构造一个对角矩阵，diag(A,K)，K为正是主对角线上第K条，否则是线下


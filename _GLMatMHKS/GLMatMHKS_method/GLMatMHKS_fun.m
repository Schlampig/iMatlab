function [GLMatStruct] = GLMatMHKS_fun(train_binary_data,train_binary_label,InputPar,M_row,M_col,L)

%计算GLMatMHKS的核心函数（注：在R2013a上运行，其他版本可能会有小错）
%train_binary_data：训练数据集，每一行一个样本
%train_binary_label：训练数据集对应的类标号
%InputPar：参数，包含k、C、lam等
%M_row：当前矩阵化的行数
%M_col：当前矩阵化的列数
%L：ARLE产生的全局局部度量矩阵

[~,tempt_location] = unique(train_binary_label);%[a,b]=unique(A),a返回向量A中不重复的元素，每种一个；b返回第一个不同元素的位置
n1 = tempt_location(2) - tempt_location(1);%n1和n2分别是第一类和第二类的样本数
n2 = size(L,1) - n1;%L是个n*n的方阵
train_binary_label(1:n1) = 1;%转类标号为1和-1
train_binary_label(n1+1:n1+n2) = -1;

%初始化参数
total_iter = 100;
u = zeros(M_row + 1,total_iter);
v = zeros(M_col + 1,total_iter);
b = zeros(n1+n2,total_iter);
e = zeros(n1+n2,total_iter);
u(:,1) = [InputPar.u * ones(M_row,1);1];%u的最后一行为1
b(:,1) = InputPar.b * ones(n1+n2,1);
I = ones(n1+n2,1);%公式中用到的全1向量
S_1 = M_row*eye(M_row);
S_2 = M_col*eye(M_col);
S1 = [S_1 zeros(size(S_1,1),1);zeros(1,size(S_1,2)) 1];
S2 = [S_2 zeros(size(S_2,1),1);zeros(1,size(S_2,2)) 1];
rho = 0.99;%p
eta = 10^(-4);%判断终止的条件
k_iter = 1;


%开始迭代训练
while (k_iter < total_iter)
          
    v(:,k_iter) = gl_get_v(train_binary_data,train_binary_label,InputPar,M_row,M_col,S2,I,u(:,k_iter),b(:,k_iter),L);
    e(:,k_iter) = gl_get_e(train_binary_data,train_binary_label,M_row,M_col,I,u(:,k_iter),v(:,k_iter),b(:,k_iter));
    b(:,k_iter+1) = b(:,k_iter) + rho*(e(:,k_iter) + abs(e(:,k_iter)));
    stop_tag = norm(b(:,k_iter+1) - b(:,k_iter),2);
    
    if stop_tag < eta
        break;
    else
        u(:,k_iter+1) = gl_get_u(train_binary_data,train_binary_label,InputPar,M_row,M_col,S1,I,v(:,k_iter),b(:,k_iter),L);
    end%end_if    
    k_iter = k_iter + 1;
    
end%while

if k_iter == total_iter
    GLMatStruct.u = u(:,k_iter);
    GLMatStruct.v = v(:,k_iter-1);
else
    GLMatStruct.u = u(:,k_iter);
    GLMatStruct.v = v(:,k_iter);    
end%end_if

%clear all;




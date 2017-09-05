function [MHKSStruct] = MHKS_fun(train_binary_data,train_binary_label,InputPar)

%计算MHKS的核心函数（注：在R2013a上运行，其他版本可能会有小错）
%train_binary_data：训练数据集，每一行一个样本
%train_binary_label：训练数据集对应的类标号
%InputPar：参数，包含C、b等


[~,tempt_location] = unique(train_binary_label);%[a,b]=unique(A),a返回向量A中不重复的元素，每种一个；b返回第一个不同元素的位置
n1 = tempt_location(2) - tempt_location(1);%n1和n2分别是第一类和第二类的样本数
n2 = size(train_binary_label,1) - n1;%L是个n*n的方阵
train_binary_label(1:n1) = 1;%转类标号为1和-1
train_binary_label(n1+1:n1+n2) = -1;

%初始化参数
total_iter = 100;
w = zeros(size(train_binary_data,2),total_iter);
b = zeros(n1+n2,total_iter);
e = zeros(n1+n2,total_iter);
b(:,1) = InputPar.b * ones(n1+n2,1);
I = ones(n1+n2,1);%公式中用到的全1向量
I_new = eye(size(train_binary_data,2));%用于和C相乘的单位向量
rho = 0.99;%p
eta = 10^(-4);%判断终止的条件
k_iter = 1;


%开始迭代训练
while (k_iter < total_iter)
          
    w(:,k_iter) = mat_get_w(train_binary_data,train_binary_label,InputPar,I,I_new,b(:,k_iter));
    e(:,k_iter) = mat_get_e(train_binary_data,train_binary_label,I,I_new,w(:,k_iter),b(:,k_iter));
    b(:,k_iter+1) = b(:,k_iter) + rho*(e(:,k_iter) + abs(e(:,k_iter)));
    stop_tag = norm(b(:,k_iter+1) - b(:,k_iter),2);
    
    if stop_tag < eta
        break;
    else
    k_iter = k_iter + 1;
    end%end_if    
    
end%while

if k_iter == total_iter
    MHKSStruct.w = w(:,k_iter-1);
    MHKSStruct.b = b(:,k_iter-1);
else
    MHKSStruct.w = w(:,k_iter); 
    MHKSStruct.b = b(:,k_iter);
end%end_if






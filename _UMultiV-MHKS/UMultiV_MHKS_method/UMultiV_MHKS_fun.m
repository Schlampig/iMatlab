function [UMultiVStruct] = UMultiV_MHKS_fun(train_binary_data,train_binary_label,C,zet,gama,uscale,M_row,M_col)

%UMultiV-MHKS核心代码，1对1的UMultiV测试（包含调用生成Universum样本的函数）
%train_binary_data：用于当前训练的数据样本
%train_binary_label：用于当前训练的数据样本对应的类标号
%gama：松弛因子1
%C:松弛因子2
%zet：控制正则项的惩罚因子
%scale：控制Universum样本规模的因子
%M_row：矩阵化的行数
%M_col：矩阵化的列数

[~,tempt_location] = unique(train_binary_label);
n1 = tempt_location(1);%n1和n2分别是第一类和第二类的样本数
n2 = tempt_location(2) - tempt_location(1);
train_binary_label(1:n1) = 1;
train_binary_label(n1+1:n1+n2) = -1;


universum_data = Universum_Generate(train_binary_data,train_binary_label,n1,n2,uscale);%调用生成Universum的函数，生成Universum样本

%初始化参数
M = size(M_row,1);
r_q = 1/M;
p = 0.99;
total_iter = 100;
k = 1;

%定义视角结构体Result.U,Result.V和Result(k_view).V0记录不同视角M下需要用到的u,v和v0
Nu = size(universum_data,1);%Universum样本总数
N = size(train_binary_label,1);%样本总数
M = size(M_row,1);%视角总数
for k_view = 1:M
    Result(k_view).U = zeros(M_row(k_view),total_iter+1);
    Result(k_view).V = zeros(M_col(k_view)+1,total_iter+1);
    Result(k_view).B = zeros(N,total_iter+1);
    Result(k_view).S1 = M_row(k_view)*eye(M_row(k_view));%S1=m*Im.m
    tempt_S2 = M_col(k_view)*eye(M_col(k_view)+1);%S2=n*In+1.n+1
    tempt_S2(M_col(k_view)+1,M_col(k_view)+1) = 0;
    Result(k_view).S2 = tempt_S2;%这里S2相当于S2~
    Result(k_view).E = zeros(N,total_iter+1);
        
    Result(k_view).U(:,k) = ones(M_row(k_view),1);
    Result(k_view).V(:,k) = ones(M_col(k_view)+1,1);
    Result(k_view).B(:,k) = ones(N,1);
end%end_for_k_view


%开始迭代训练
while (k <= total_iter)

    %一个视角的一次迭代
    for k_v_p = 1:M    
        Result(k_v_p).V(:,k+1) = To_get_v(Result,train_binary_data,train_binary_label,universum_data,r_q,C,zet,gama,M,N,Nu,M_row,M_col,k_v_p,k);
        Result(k_v_p).E(:,k) = To_get_e(Result,train_binary_data,train_binary_label,M_row,M_col,N,k_v_p,k);
        Result(k_v_p).B(:,k+1) = Result(k_v_p).B(:,k) + p*(Result(k_v_p).E(:,k) + abs(Result(k_v_p).E(:,k)));
        Result(k_v_p).U(:,k+1) = To_get_u(Result,train_binary_data,train_binary_label,universum_data,M,N,Nu,M_row,M_col,C,zet,gama,r_q,k_v_p,k);
    end%end_for_k_v_p
    
    stop_tag = isConver(Result,total_iter,train_binary_data,train_binary_label,universum_data,C,zet,gama,M,N,Nu,M_row,M_col,k);
    
    if stop_tag == 1
        break;
    else
        k = k + 1;
    end%end_if
    
end%while

for k_v_f = 1:M
    UMultiVStruct(k_v_f).u = Result(k_v_f).U(:,k);
    UMultiVStruct(k_v_f).v = Result(k_v_f).V(:,k);
end%end_for_k_v_f


%clear all;







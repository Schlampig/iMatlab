function [C_final] = Lglocal_fun(train_binary_data,train_binary_label,k)

%生成L^Glocal矩阵的函数

%按照类标号分成L1_glocal和L2_glocal
[~,tempt_location] = unique(train_binary_label);%[a,b]=unique(A),a返回向量A中不重复的元素，每种一个；b返回第一个不同元素的位置
n1 = tempt_location(2) - tempt_location(1);%n1和n2分别是第一类和第二类的样本数
n2 = size(train_binary_label,1) - n1;
train_sample(1).class = train_binary_data(1:n1,:);%分离两类样本
train_sample(2).class = train_binary_data(n1+1:n1+n2,:);

for i_Lglocal = 1:2
    X = train_sample(i_Lglocal).class';%当前样本
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
    C_2 = -C_2;
    
    d = sum(d_i);
    w_global = d_i/d;
    C_3 = diag(w_global,0);%diag构造一个对角矩阵，diag(A,K)，K为正是主对角线上第K条，否则是线下
    
    L(i_Lglocal).matrix = C_2*C_3*C_2';
    clear C_0; clear C_1; clear C_2; clear C_3;
end%end_for_i_Lglocal
 
C_final = [L(1).matrix zeros(size(L(1).matrix,1),size(L(2).matrix,2));zeros(size(L(2).matrix,1),size(L(1).matrix,2)) L(2).matrix];













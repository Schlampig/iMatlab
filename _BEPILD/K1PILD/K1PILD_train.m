function [wk,w0k] = K1PILD_train(train_all, par)


%读取参数
dp_index = par.dp;
num_reg = par.reg;
ker_type = par.ktype;
ker_par = par.kpara;

% 预处理
[row_train,col_train] = size(train_all);
train_pos = train_all(find(train_all(:,end)==1),1:end-1);%找出所有训练的正类样本组成train_pos,无标号
train_neg = train_all(find(train_all(:,end)==0),1:end-1);%找出所有训练的负类样本组成train_neg，无标号
dp = dp_Gernerate(dp_index,train_all(:,end));%生成dp
X = [ones(row_train,1),[train_pos;train_neg]];%POS类放在前面，NEG类放在后面，生成训练样本矩阵 X in N*(D+1)
% Y = X'; % Y in (D+1)*N

%计算核矩阵K
K =  kernel_fun(X, X, ker_type, ker_par); % K in N*N

%使用KPILD计算最初的超平面
v = inv(K'*K + num_reg*K)*K'*dp; % v in N*1
wk_all = X'*v; % w_all in (D+1)*1
wk = wk_all(2:end,1);
w0k = wk_all(1,1);%w_all的第一个元素是θ（w0），之后是w

end
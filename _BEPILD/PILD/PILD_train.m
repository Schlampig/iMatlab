function [w,w0] = PILD_train(train_all,dp_index)

[row_train,col_train] = size(train_all);

train_pos = train_all(find(train_all(:,end)==1),:);%找出所有训练的正类样本组成train_pos
train_neg = train_all(find(train_all(:,end)==0),:);%找出所有训练的负类样本组成train_neg
dp = dp_Gernerate(dp_index,train_all(:,col_train));%生成dp
X = [ones(row_train,1),[train_pos;train_neg]];%POS类放在前面，NEG类放在后面，生成训练样本矩阵

w_all = inv(X'*X)*X'*dp;%伪逆法计算权重向量w_all(列向量)

w = w_all(2:col_train,1);
w0 = w_all(1,1);%w_all的第一个元素是θ（w0），之后是w

end
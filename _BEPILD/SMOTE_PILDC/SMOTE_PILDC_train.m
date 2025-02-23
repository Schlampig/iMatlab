function [w,w0,bpos,bneg,candi_dis_pos,candi_dis_neg] = SMOTE_PILDC_train(train_all,dp_index)

[row_train,~] = size(train_all);

train_pos = train_all(find(train_all(:,end)==1),1:end-1);%找出所有训练的正类样本组成train_pos
train_neg = train_all(find(train_all(:,end)==0),1:end-1);%找出所有训练的负类样本组成train_neg
dp = dp_Gernerate(dp_index,train_all(:,end));%生成dp
X = [ones(row_train,1),[train_pos;train_neg]];%POS类放在前面，NEG类放在后面，生成训练样本矩阵

w_all = inv(X'*X)*X'*dp;%伪逆法计算权重向量w_all(列向量)

w = w_all(2:end,1);
w0 = w_all(1,1);%w_all的第一个元素是θ（w0），之后是w



upos = mean(train_pos(:,:))';%求正类训练样本均值点，是个d维的向量
uneg = mean(train_neg(:,:))';%求负类训练样本均值点

bpos = -w'*upos;%分别求过两类质心与分类面平行的面的截距
bneg = -w'*uneg;

X_temp = X(:,2:end);

pos_index = sum(repmat(w',row_train,1).*X_temp,2) + bpos*ones(row_train,1);
neg_index = sum(repmat(w',row_train,1).*X_temp,2) + bneg*ones(row_train,1);

train_new = train_all(intersect(find(pos_index<0),find(neg_index>0)),:);%选出介于过两质心平行于分类面的平面间的样本点作为新的训练样本点，带标号
train_new_pos = train_new(find(train_new(:,end)==1),:);%找出新训练的正类样本组成train_new_pos
train_new_neg = train_new(find(train_new(:,end)==0),:);%找出新训练的正类样本组成train_new_neg

[train_new_pos_r,~] = size(train_new_pos);
[train_new_neg_r,~] = size(train_new_neg);
candi_dis_pos = abs(sum(repmat(w',train_new_pos_r,1) .* train_new_pos(:,1:end-1),2) + bpos*ones(train_new_pos_r,1));%求出所有训练pos点到质心的距离
candi_dis_neg = abs(sum(repmat(w',train_new_neg_r,1) .* train_new_neg(:,1:end-1),2) + bneg*ones(train_new_neg_r,1));%求出所有训练neg点到质心的距离

end
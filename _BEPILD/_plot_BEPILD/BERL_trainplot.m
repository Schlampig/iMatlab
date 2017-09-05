function [model] = BERL_trainplot(train_all)

% 训练随机BEPILD用于绘图的算法
% train_all： 每行一个样本，最后一列是类标号，0是多数类，1是少数类

% 预处理
[row_train,col_train] = size(train_all);
train_pos = train_all(find(train_all(:,end)==1),1:end-1);%找出所有训练的正类样本组成train_pos,无标号
train_neg = train_all(find(train_all(:,end)==0),1:end-1);%找出所有训练的负类样本组成train_neg，无标号
X = [ones(row_train,1),[train_pos;train_neg]];%POS类放在前面，NEG类放在后面，生成训练样本矩阵

% 使用随机方法得到最初的超平面
% rng(42);%固定伪随机
a = -1;
b = 1;
w = a + (b-a).*rand(col_train-1,1); 
w = w/norm(w,'fro');% 归一化

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

model.w = w;
model.bpos = bpos;
model.bneg = bneg;
model.candi_dis_pos = candi_dis_pos;
model.candi_dis_neg = candi_dis_neg;

end%function


















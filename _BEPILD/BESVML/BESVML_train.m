function [model,flag] = BESVML_train(train_all, C)

% 训练BESVML的算法
%train_all： 每行一个样本，最后一列是类标号，0是多数类，1是少数类

%预处理
train_pos = train_all(find(train_all(:,end)==1),1:end-1);%找出所有训练的正类样本组成train_pos,无标号
train_neg = train_all(find(train_all(:,end)==0),1:end-1);%找出所有训练的负类样本组成train_neg，无标号

%训练初始分类面
option=svmsmoset('MaxIter',3000000);%设置最大迭代次数
SVMmodel = svmtrain(train_all(:,1:end-1),train_all(:,end),'kernel_function','linear','method','SMO','boxconstraint',C,'SMO_OPTS',option);
mat_sv = SVMmodel.SupportVectors;%支持向量矩阵，一行一个样本，列是维数
vec_alpha = SVMmodel.Alpha; %支持向量权重α，一个列向量
b = SVMmodel.Bias; %截距b，一个标量

% 根据prediction找出正负类最接近边缘的点
[num_min_pos,~] = min(svmlpre(train_pos,mat_sv,vec_alpha,b));
[num_max_neg,~] = min(svmlpre(train_neg,mat_sv,vec_alpha,b));

if num_min_pos >= num_max_neg %正负类没有相交，线性分类面可以分开二者  
    flag = 1;
    model = SVMmodel;

else%存在相交区域
    flag = 0;
    
    upos = mean(train_pos);%求正类训练样本均值点，是个d维的向量
    uneg = mean(train_neg);%求负类训练样本均值点
    bpos = svmlb(upos, mat_sv, vec_alpha);%分别求过两类质心与分类面平行的面的截距
    bneg = svmlb(uneg, mat_sv, vec_alpha);  
    
    pos_index = svmlpre(train_pos,mat_sv,vec_alpha,bpos);  
    neg_index = svmlpre(train_neg,mat_sv,vec_alpha,bneg);

    train_new = train_all(intersect(find(pos_index<0),find(neg_index>0)),:);%选出介于过两质心平行于分类面的平面间的样本点作为新的训练样本点，带标号
    train_new_pos = train_new(find(train_new(:,end)==1),1:end-1);%找出新训练的正类样本组成train_new_pos
    train_new_neg = train_new(find(train_new(:,end)==0),1:end-1);%找出新训练的正类样本组成train_new_neg

    [train_new_pos_r,~] = size(train_new_pos);
    [train_new_neg_r,~] = size(train_new_neg);
    candi_dis_pos = abs(svmlpre(train_new_pos,mat_sv,vec_alpha,bpos));%求出所有训练pos点到质心的距离
    candi_dis_neg = abs(svmlpre(train_new_neg,mat_sv,vec_alpha,bneg));%求出所有训练neg点到质心的距离

    model.mat_sv = mat_sv;
    model.vec_alpha = vec_alpha;
    model.b = b;
    model.bpos = bpos;
    model.bneg = bneg;
    model.candi_dis_pos = candi_dis_pos;
    model.candi_dis_neg = candi_dis_neg;
end%if



end%function


















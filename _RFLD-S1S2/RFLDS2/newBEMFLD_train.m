function [model,flag] = newBEMFLD_train(train_all, dp_index, num_reg, k, c)

% 训练BEMFLD的算法
% train_all： 每行一个样本，最后一列是类标号，0是多数类，1是少数类
% dp_index:用来选择生成的dp（理想label）值，代入dp_Gernerate()
% num_reg: 正则化权重参数，标量， reg=0即不加扰动，reg越大扰动越大
% k：计算Slw需要近邻个数
% c：权值因子，cSw+(1-c)Slw

% 预处理
[row_train, col_train] = size(train_all);
train_pos = train_all(find(train_all(:,end)==1),1:end-1);%找出所有训练的正类样本组成train_pos,无标号
train_neg = train_all(find(train_all(:,end)==0),1:end-1);%找出所有训练的负类样本组成train_neg，无标号
dp = dp_Gernerate(dp_index,train_all(:,end));%生成dp
X = [train_pos;train_neg];%POS类放在前面，NEG类放在后面，生成训练样本矩阵 NxD，无标号
I_reg = num_reg * eye(col_train-1); %生成正则化扰动项


% 计算Sw和Slw
% 计算Sw和m1、m2（有监督）
[S1,m1] = SCAM(train_pos);
[S2,m2] = SCAM(train_neg);
Sw = S1 + S2; % Sw、S1、S2都是DxD维, 注意m1与m2是1xD维

%计算Slw（有监督）
options = [];
options.NeighborMode = 'Supervised';
options.gnd = train_all(:,end);%全部训练样本的类别标记列向量
options.NeighborMode = 'KNN';
options.k = k;
options.WeightMode = 'HeatKernel';
options.t = 1;
W = constructW(X,options);%求关联矩阵
D = diag(sum(W,2));
Slw = X'*(D-W)*X;%变成d*d的半正定阵

% 求原始超平面参数w与w0
w = inv(c*Sw + (1-c)*Slw + I_reg)*(m1 - m2)'; % Dx1
w0 = - sum(X*w - dp)/row_train; % 1x1

% BE-model:
% 找出正负类最接近边缘的点，使用 predict = w'*x + w0
[num_min_pos,index_min_pos] = min(sum(repmat(w',size(train_pos,1),1).*train_pos,2) + w0*ones(size(train_pos,1),1));
[num_max_neg,index_max_neg] = max(sum(repmat(w',size(train_neg,1),1).*train_neg,2) + w0*ones(size(train_neg,1),1));

if num_min_pos > num_max_neg %正负类没有相交，线性分类面可以分开二者， 以两边界点中点为新中心，过该点作线
    flag = 1;
    mcenter = mean(train_pos(index_min_pos,:) + train_neg(index_max_neg,:)); %边界点中心点
    bcenter = -w'*mcenter; %中心点截距
    model.w = w;
    model.w0 = bcenter;
elseif num_min_pos == num_max_neg % 正负类相交的地方正好是边界，以边界为中心作新直线
    flag = 1;
    bcenter = -w'*train_pos(index_min_pos,:)';
    model.w = w;
    model.w0 = bcenter;
else%存在相交区域
    flag = 0;
    
    upos = mean(train_pos(:,:))';%求正类训练样本均值点，是个d维的向量
    uneg = mean(train_neg(:,:))';%求负类训练样本均值点
    bpos = -w'*upos;%分别求过两类质心与分类面平行的面的截距
    bneg = -w'*uneg;
    
    pos_index = sum(repmat(w',row_train,1).*X,2) + bpos*ones(row_train,1);
    neg_index = sum(repmat(w',row_train,1).*X,2) + bneg*ones(row_train,1);

    train_new = train_all(intersect(find(pos_index<0),find(neg_index>0)),:);%选出介于过两质心平行于分类面的平面间的样本点作为新的训练样本点，带标号
    train_new_pos = train_new(find(train_new(:,end)==1),:);%找出新训练的正类样本组成train_new_pos
    train_new_neg = train_new(find(train_new(:,end)==0),:);%找出新训练的正类样本组成train_new_neg

    [train_new_pos_r,~] = size(train_new_pos);
    [train_new_neg_r,~] = size(train_new_neg);
    candi_dis_pos = abs(sum(repmat(w',train_new_pos_r,1) .* train_new_pos(:,1:end-1),2) + bpos*ones(train_new_pos_r,1));%求出所有训练pos点到质心的距离
    candi_dis_neg = abs(sum(repmat(w',train_new_neg_r,1) .* train_new_neg(:,1:end-1),2) + bneg*ones(train_new_neg_r,1));%求出所有训练neg点到质心的距离

    model.w = w;
    model.w0 = w0;
    model.bpos = bpos;
    model.bneg = bneg;
    model.candi_dis_pos = candi_dis_pos;
    model.candi_dis_neg = candi_dis_neg;
end%if



end%function


















function [clf] = RFLD_train(train_all, par)

% 训练MFLD的算法
% train_all： 每行一个样本，最后一列是类标号，0是多数类，1是少数类
% dp_index:用来选择生成的dp（理想label）值，代入dp_Gernerate()
% num_reg: 正则化权重参数，标量， reg=0即不加扰动，reg越大扰动越大
% k：计算Slw需要近邻个数
% c：惩罚因子，cSw+(1-c)Slw

% 赋值
dp_index = par.dp;
num_reg = par.reg;
k = par.k;
c = par.c;

% 预处理
[row_train, col_train] = size(train_all);
train_pos = train_all(find(train_all(:,end)==1),1:end-1);%找出所有训练的正类样本组成train_pos,无标号
train_neg = train_all(find(train_all(:,end)==0),1:end-1);%找出所有训练的负类样本组成train_neg，无标号
dp = get_dp(dp_index,train_all(:,end));%生成dp
X = train_all(:,1:end-1);% 生成训练样本矩阵 NxD
I_reg = num_reg * eye(col_train-1); % 生成正则化扰动项


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
w = inv( c*Sw + (1-c)*Slw + I_reg)*(m1 - m2)'; % Dx1
w0 = - sum(X*w - dp)/row_train; % 1x1

% 生成模型
clf.w = w;
clf.w0 = w0;

end%function
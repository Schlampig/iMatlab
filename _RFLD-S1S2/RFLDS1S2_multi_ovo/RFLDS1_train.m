function [clf] = RFLDS1_train(train_all, par)

% 训练RFLDS1的算法
% train_all： 每行一个样本，最后一列是类标号，0是多数类，1是少数类
% dp_index:用来选择生成的dp（理想label）值，代入dp_Gernerate()
% num_reg: 正则化权重参数，标量， reg=0即不加扰动，reg越大扰动越大
% k：计算Slw需要近邻个数
% c：权值因子，cSw+(1-c)Slw
% theta:阈值选择标记

% 赋 值
dp_index = par.dp;
num_reg = par.reg;
theta = par.theta;
k = par.k;
c = par.c;

% 初始化
dp = get_dp(dp_index,train_all(:,end));%生成dp
I_reg = num_reg * eye(size(train_all,2)-1); %生成正则化扰动项

X_pos = train_all(find(train_all(:,end)==1),1:end-1);% 正类训练样本矩阵,无标号
X_neg = train_all(find(train_all(:,end)==0),1:end-1);% 负类训练样本矩阵，无标号
N_pos = size(X_pos,1);% 训练样本正类个数
N_neg = size(X_neg,1);% 训练样本负类个数
X_all = train_all(:,1:end-1);% 总训练样本矩阵 NxD

% 计算类内离散度矩阵Sw和均值m_pos、m_neg 
[S_pos,m_pos] = SCAM(X_pos);
[S_neg,m_neg] = SCAM(X_neg);
Sw = S_pos + S_neg; % Sw、S_pos、S_neg都是DxD维, 注意m_pos与m_neg是1xD维

%计算Slw（有监督）
options = [];
options.NeighborMode = 'Supervised';
options.gnd = train_all(:,end);%全部训练样本的类别标记列向量
options.NeighborMode = 'KNN';
options.k = k;
options.WeightMode = 'HeatKernel';
options.t = 1;
W = constructW(X_all,options);%求关联矩阵
D = diag(sum(W,2));
Slw = X_all'*(D-W)*X_all;%变成d*d的半正定阵

% 计算权值向量w
w = inv(c*Sw + (1-c)*Slw + I_reg)*(m_pos - m_neg)'; % Dx1

% 计算投影均值向量u_pos与u_neg及投影均方差向量o_pos与o_neg
u_pos = mean(X_pos*w); % 以下四个值都是 1x1
u_neg = mean(X_neg*w);
o_pos = std(X_pos*w);
o_neg = std(X_neg*w);

% 生成两类质心间正负类样本Xb_pos与Xb_neg，及其个数Nb_pos，Nb_neg
[Xb_pos,Nb_pos] = get_between(X_pos,w,u_pos,u_neg);
[Xb_neg,Nb_neg] = get_between(X_neg,w,u_pos,u_neg);

% 计算四个参数par1，par2，par3，par4
par1_pos = get_par(X_pos,N_pos,w,u_pos,0); %都是1x1
par1_neg = get_par(X_neg,N_neg,w,u_neg,0);
par2_pos = get_par(Xb_pos,Nb_pos,w,u_pos,0);
par2_neg = get_par(Xb_neg,Nb_neg,w,u_neg,0);
par3_pos = get_par(X_pos,N_pos,w,u_pos,1);
par3_neg = get_par(X_neg,N_neg,w,u_neg,1);
par4_pos = get_par(Xb_pos,Nb_pos,w,u_pos,1);
par4_neg = get_par(Xb_neg,Nb_neg,w,u_neg,1);

% 根据theta取值计算w0
if theta ~= 11
    switch theta
        case 1 % 即传统FLD，通常作为对比
            w0 = - sum(X_all*w - dp)/(N_pos + N_neg); % 1x1
        case 2
            w0 = - (u_pos + u_neg)/2;
        case 3
            w0 = - (N_neg*u_pos + N_pos*u_neg)/(N_pos + N_neg);
        case 4
            w0 = - (o_neg*u_pos + o_pos*u_neg)/(o_pos + o_neg);
        case 5
            w0 = - ((N_neg*u_pos + N_pos*u_neg)/(N_pos + N_neg) + (o_neg*u_pos + o_pos*u_neg)/(o_pos + o_neg))/2 ; % 即 （w0_3 + w0_4）/2
        case 6
            w0 = - (par1_neg*u_pos + par1_pos*u_neg)/(par1_pos + par1_neg);
        case 7
            a = 1/o_pos^2 - 1/o_neg^2;
            b = -2*(u_pos/o_pos - u_neg/o_neg);
            c = 2*(log(o_pos)-log(o_neg)) + ((u_pos/o_pos)^2 - (u_neg/o_neg)^2);
            w0 = - 1/(2*a) * (- b - sqrt(b^2-4*a*c));
        case 8
            w0 = - (par2_neg*u_pos + par2_pos*u_neg)/(par2_pos + par2_neg);
        case 9
            w0 = - (par3_neg*u_pos + par3_pos*u_neg)/(par3_pos + par3_neg);
        case 10
            w0 = - (par4_neg*u_pos + par4_pos*u_neg)/(par4_pos + par4_neg);
    end%switch
else
    w2 = - (u_pos + u_neg)/2;
    w3 = - (N_neg*u_pos + N_pos*u_neg)/(N_pos + N_neg);
    w4 = - (o_neg*u_pos + o_pos*u_neg)/(o_pos + o_neg);
    w5 = - ((N_neg*u_pos + N_pos*u_neg)/(N_pos + N_neg) + (o_neg*u_pos + o_pos*u_neg)/(o_pos + o_neg))/2 ; % 即 （w0_3 + w0_4）/2
    w6 = - (par1_neg*u_pos + par1_pos*u_neg)/(par1_pos + par1_neg);
    a = 1/o_pos^2 - 1/o_neg^2;
    b = -2*(u_pos/o_pos - u_neg/o_neg);
    c = 2*(log(o_pos)-log(o_neg)) + ((u_pos/o_pos)^2 - (u_neg/o_neg)^2);
    w7 = - 1/(2*a) * (-b-sqrt(b^2-4*a*c));
    w8 = - (par2_neg*u_pos + par2_pos*u_neg)/(par2_pos + par2_neg);
    w9 = - (par3_neg*u_pos + par3_pos*u_neg)/(par3_pos + par3_neg);
    w10 = - (par4_neg*u_pos + par4_pos*u_neg)/(par4_pos + par4_neg);
    w0 = (w2 + w3 + w4 + w5 + w6 + w7 + w8 + w9 + w10)/9; % w0是前面各种w0组合的均值（传统FLD除外）
end%if

clf.w = w;
clf.w0 = w0;

end
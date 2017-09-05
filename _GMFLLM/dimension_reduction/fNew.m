function fNew(a,k,Rdim,dataname,dataname_index,a_index)


% 合成算法New
% Rdim：保留维数
% a:分子与分母间的参数
% k:近邻数
% a_index = 0-7%控制算法


if dataname_index == 1
    eval(['load ',dataname,'_32x32.mat']);
else
    eval(['load ',dataname,'.mat']);
end%if_index

data = fea;%每行一个样本，N*d维
[~,d] = size(data);


%求类内矩阵（多类）
Sw = zeros(d);
inclass_num = zeros(max(gnd),1);%存放每一类样本数的向量
mat_mean = [];%初始化存放每一类均值向量的矩阵，一行一个均值向量
for i_class = 1:max(gnd)
    data_tempor = data(find(gnd == i_class),:);
    [W_tempor,vec_mean] = SCAM(data_tempor);%求关联矩阵
    Sw = Sw + W_tempor;
    mat_mean = [mat_mean;vec_mean];
    inclass_num(i_class) = inclass_num(i_class) + 1;%统计当前类样本总数
    clear W_tempor;clear data_tempor;clear vec_mean;
end%for_i_class
mat_mean = [mat_mean,inclass_num];

%求类间矩阵（多类）
[Sb,~] = SCAMc(mat_mean);%求关联矩阵

%求样本关联矩阵W（有监督）
options = [];
options.NeighborMode = 'Supervised';
options.gnd = gnd;
options.NeighborMode = 'KNN';
options.k = k;
options.WeightMode = 'HeatKernel';
options.t = 1;
W = constructW(data,options);%求关联矩阵
D = diag(sum(W,2));
WPrime = data'*(D-W)*data;%变成d*d的半正定阵

%求类关联矩阵F
sum_class = max(gnd);
cdata = [];%存放各个类的均值矩阵
for i_class = 1:sum_class
    data_class = data(find(gnd == i_class),:);%选出第i_class类所有训练样本求关联矩阵
    cdata = [cdata;mean(data_class)];%记录第i_class类所有训练样本均值
end%for_i_class
options2 = [];
options2.NeighborMode = 'KNN';
options2.k = k;
options2.WeightMode = 'HeatKernel';
options2.t = 1;
F = constructW(cdata,options2);%求类关联矩阵
E = diag(sum(F,2));
FPrime = cdata'*(E-F)*cdata;     

%求总的类内关联矩阵A和总的类间关联矩阵B
switch a_index %根据数据集标号选择数据集 
    case 1
        A = WPrime;
        B = Sb;
        algname = 'New1_';
    case 2
        A = Sw + WPrime;
        B = Sb;
        algname = 'New2_';
    case 3
        A = Sw + WPrime;
        B = FPrime;
        algname = 'New3_';
    case 4
        A = Sw;
        B = FPrime;
        algname = 'New4_';
    case 5
        A = Sw;
        B = Sb +  FPrime;
        algname = 'New5_';
    case 6
        A = WPrime;
        B = Sb +  FPrime;
        algname = 'New6_';
    case 7
        A = Sw +  WPrime;
        B = Sb +  FPrime;
        algname = 'New7_';
    otherwise
        disp('You have input wrong algorithm number!');%报错 
end%switch

%特征提取部分for MMC型
St = B - a*A;%d*d
I = eye(d);
[TMat] = get_eigen(St,I,Rdim);%特征值分解降维，TMat是d*Rdim维

% %特征提取部分for LDA型
% [TMat] = get_eigen(B,A,Rdim);%特征值分解降维，TMat是d*Rdim维


fea = data*TMat;
gnd = gnd;

save(['m',algname,dataname,num2str(Rdim),'_k',num2str(k),'_a',num2str(a),'.mat'],'fea','gnd');%存储降维后的数据集

end%function

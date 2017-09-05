function fCLPP(a,k,kc,Rdim,dataname,dataname_index)


% 合成算法New
% Rdim：保留维数
% a:分子与分母间的参数
% k:近邻数
% kc:普查近邻数
% a_index = 0-7， 控制算法


if dataname_index == 1
    eval(['load ',dataname,'_32x32.mat']);
else
    eval(['load ',dataname,'.mat']);
end%if_index

data = fea;%每行一个样本，N*d维
[~,d] = size(data);


%————————————————————求分母A————————————————————
%求类内关联矩阵W
options = [];
options.NeighborMode = 'KNN';
options.k = kc;
options.WeightMode = 'HeatKernel';
options.t = 1;
W = constructW(data,options);%求关联矩阵
%生成普查矩阵C
C = constructC(W);
W = W + C;
D = diag(sum(W,2));
A = data'*(D-W)*data;%变成d*d的半正定阵


%————————————————————求分子B————————————————————
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
B = Sb +  FPrime;

%————————————————————组成联合矩阵————————————————————
St = B - a*A;%d*d
I = eye(d);

%————————————————————特征值分解降维————————————————————
[TMat] = get_eigen(St,I,Rdim);%TMat是d*Rdim维

fea = data*TMat;
gnd = gnd;

save(['New5_',dataname,num2str(Rdim),'_k',num2str(k),'_kc',num2str(kc),'_a',num2str(a),'.mat'],'fea','gnd');%存储降维后的数据集

end%function

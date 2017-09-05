function fDLPPMMC(a,k,Rdim,dataname,dataname_index)


% 采用统一规则进行降维的DLPP/MMC算法，没有先用PCA去掉主元，使用的maxarg w'(YFY' - aXWX)w
% Rdim：保留维数
% a:XWX与YFY'之间的参数
% k:近邻数

if dataname_index == 1
    eval(['load ',dataname,'_32x32.mat']);
else
    eval(['load ',dataname,'.mat']);
end%if_index

data = fea;%每行一个样本，N*d维
[~,d] = size(data);

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

St = FPrime - a*WPrime;%d*d
I = eye(d);

%特征值分解降维
[TMat] = get_eigen(St,I,Rdim);%TMat是d*Rdim维

fea = data*TMat;
gnd = gnd;

save(['DLPPMMC_',dataname,num2str(Rdim),'_k',num2str(k),'_a',num2str(a),'.mat'],'fea','gnd');%存储降维后的数据集

end%function

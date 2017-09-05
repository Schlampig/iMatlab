function fLPP(k,Rdim,dataname,dataname_index)


% 采用统一规则进行降维的原始LPP算法，没有先用PCA去掉主元，使用的maxarg w'X(W-uD)X'w
% k:近邻数
% Rdim：保留维数

if dataname_index == 1
    eval(['load ',dataname,'_32x32.mat']);
else
    eval(['load ',dataname,'.mat']);
end%if_index

data = fea;%每行一个样本，N*d维
[~,d] = size(data);

options = [];
options.NeighborMode = 'KNN';
options.k = k;
options.WeightMode = 'HeatKernel';
options.t = 1;

W = constructW(data,options);%求关联矩阵
D = diag(sum(W,2));%列向量  
WPrime = data'*W*data;%变成d*d的半正定阵
DPrime = data'*D*data;   


%求类间矩阵（多类）
[TMat] = get_eigen(WPrime,DPrime,Rdim);%TMat是d*Rdim维    

fea = data*TMat;
gnd = gnd;

save(['LPP_',dataname,num2str(Rdim),'_k',num2str(k),'.mat'],'fea','gnd');%存储降维后的数据集

end%function
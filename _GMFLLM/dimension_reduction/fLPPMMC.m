function fLPPMMC(a,k,Rdim,dataname,dataname_index)


% 采用统一规则进行降维的LPP第3号算法，没有先用PCA去掉主元，使用的maxarg w'X(W-uD)X'w
% k:近邻数
% Rdim：保留维数
% a:W与D之间的平衡参数

if dataname_index == 1
    eval(['load ',dataname,'_32x32.mat']);
else
    eval(['load ',dataname,'.mat']);
end%if_index

data = fea;%每行一个样本，N*d维
[~,d] = size(data);

W = kNNAM(data,k);%求关联矩阵
D = diag(sum(W,2));%列向量  
% vec_eigenvalue = diag(sum(W));%列向量
% D = eye(n) .*repmat(vec_eigenvalue,1,n);
WPrime = data'*W*data;%变成d*d的半正定阵
DPrime = data'*D*data;   

S = (WPrime - a*DPrime);
I = eye(d);


%求类间矩阵（多类）
[TMat] = get_eigen(S,I,Rdim);%TMat是d*Rdim维    

fea = data*TMat;
gnd = gnd;

save(['LPPMMC_',dataname,num2str(Rdim),'_k',num2str(k),'_a',num2str(a),'.mat'],'fea','gnd');%存储降维后的数据集

end%function
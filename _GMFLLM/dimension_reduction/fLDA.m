function fLDA(Rdim,dataname,dataname_index)


% 原始Fisher算法
% Rdim：保留维数

if dataname_index == 1
    eval(['load ',dataname,'_32x32.mat']);
else
    eval(['load ',dataname,'.mat']);
end%if_index

data = fea;%每行一个样本，N*d维
[~,d] = size(data);%求样本原始维数

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

%特征值分解降维
[TMat] = get_eigen(Sb,Sw,Rdim);%TMat是d*Rdim维

fea = data*TMat;
gnd = gnd;

save(['LDA_',dataname,num2str(Rdim),'.mat'],'fea','gnd');%存储降维后的数据集

end%function
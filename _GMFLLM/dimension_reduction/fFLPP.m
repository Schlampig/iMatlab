function fFLPP(k,Rdim,dataname,dataname_index)


% 非标准FLPP算法，没有先用PCA去掉主元，使用的maxarg w'XLX'w/w'XFX'w，分子无监督
% k:近邻数
% Rdim：保留维数

if dataname_index == 1
    eval(['load ',dataname,'_32x32.mat']);
else
    eval(['load ',dataname,'.mat']);
end%if_index

data = fea;%每行一个样本，N*d维
[num,d] = size(data);

%求类内关联矩阵Ww及拉普拉斯矩阵L
options = [];
options.NeighborMode = 'Supervised';
options.gnd = gnd;
options.NeighborMode = 'KNN';
options.k = k;
options.WeightMode = 'HeatKernel';
options.t = 1;
Ww = constructW(data,options);%求关联矩阵
Dw = diag(sum(Ww,2));%列向量  
L = Dw - Ww;
LPrime = data'*L*data;%变成d*d的半正定阵
  

%求类间关联矩阵Wb及拉普拉斯矩阵F  
Wb = [];%初始化类间关联矩阵 
for i_sample = 1:num
    gnd_tempor = gnd;
    gnd_tempor(find(gnd == gnd(i_sample))) = 0;
    gnd_tempor(find(gnd ~= gnd(i_sample))) = 1;%和当前样本不同类的样本类标号定为1
    gnd_tempor(i_sample) = 1;%当前样本类标号为1
    gnd_tempor(find(gnd_tempor == 0)) = 2;%和当前样本同类的样本类标号定为2
    
    options2 = [];
    options2.NeighborMode = 'Supervised';
    options2.gnd = gnd_tempor;%使用新的类标号
    options2.NeighborMode = 'KNN';
    options2.k = k;
    options2.WeightMode = 'HeatKernel';
    options2.t = 1;
    W_tempor = constructW(data,options2);%求临时关联矩阵
    vec_now = W_tempor(i_sample,:);
     
    Wb = [Wb;vec_now];%记录第i_class类所有训练样本均值
    clear gnd_tempor;clear W_tempor;clear vec_now;
end%for_i_class
Db = diag(sum(Wb,2));%列向量    
F = Db - Wb;
FPrime = data'*F*data;        

%计算特征方程
[TMat] = get_eigen(FPrime,LPrime,Rdim);%TMat是d*Rdim维    

fea = data*TMat;
gnd = gnd;

save(['FLPP_',dataname,num2str(Rdim),'_k',num2str(k),'.mat'],'fea','gnd');%存储降维后的数据集


end%function
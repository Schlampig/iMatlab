function [AMat] = kNNAM(data,k)

% k-Nearest Neighbor Affinity Matrix，带入训练样本，生成训练样本之间的相似度矩阵W，常用于LPP、热核或谱聚簇等方法。
% data:样本集，列数是维数，行数是样本数
% k:近邻数
% sigma:热核公式的核参数，分母，这里默认是data里所有样本的平均距离
% AMat:一个n*n的关系矩阵，n是data里的样本总数

%求data里的样本总数
    n = size(data,1);

%求欧氏距离矩阵
    X_0 = data';%当前样本，行数是维数，列数是样本数   
    X_1 = diag(X_0'*X_0);
    X_2 = X_1*ones(1,n) + ones(n,1)*X_1' - 2.*(X_0'*X_0);
    X_2 = sqrt(X_2);%||xi-xj||2
    
%求sigma
    %sigma = mean(mean(X_2));
    sigma = 1;
    
%求权重，距离越近权重越大，距离为0时权重为1  
    X_3 = exp(-X_2./(2*sigma^2));%exp(||xi-xj||2/sigma)
    
%求k近邻，前k+1个最大权重留下：
    k = k + 1;%因为要包含自己与自己的距离
    [~,index_1] = sort(-X_3,2);%每行一个样本，按列序排，降序(权重大的排名靠前）
    [~,index_2] = sort(index_1,2);
    X_4 = reshape(X_3,1,n*n);
    index_2 = reshape(index_2,1,n*n);
    X_4(find(index_2> k)) = 0;%找出不是近邻的样本并赋值为0
      
%求最后的关系矩阵
   AMat = reshape(X_4,n,n); 
    
end%function  
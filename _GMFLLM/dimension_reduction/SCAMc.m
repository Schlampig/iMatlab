function [FMat,m_sample] = SCAMc(alldata)

% Sample-Center Affinity Matrix for between-class，带入训练样本，生成训练样本与均值中心的相似度矩阵W，常用于Fisher等判别算法。
% 注：求不同类组成的Sb！
% data:样本集，列数是维数，行数是样本数，必须属于同一类
% FMat:一个d*d的关系矩阵，d是data里样本的维数

data = alldata(:,1:end-1);%每一类的平均样本
num = alldata(:,end);%每一类的样本数
%求均值向量
    m_sample = mean(data);%行向量
    [n,d] = size(data);
    
%求FMat
    FMat = zeros(d);
    for i = 1:n
       Mat_tempor = (data(i,:) - m_sample)'* (data(i,:) - m_sample);
       FMat = FMat + num(n)*Mat_tempor;
    end
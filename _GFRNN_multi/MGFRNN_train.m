function [model] = MGFRNN_train(train_all)


% MGFRNN的训练过程，代入训练样本，经过训练得到以下信息
% train_all：一行一个样本，最后一列是类别标记
% m：列向量，存放每个类样本的mass
% r：固定半径近邻所选择的半径
% c：训练样本集类别数
% s：训练样本总数

% 求训练样本集类别数
c = length(unique(train_all(:,end))); % 训练样本类数
sample_all = size(train_all,1); % 训练样本总数

sample = [];
d = [];
for i_c = 1:c
    
    index_now = find(train_all(:,end) == i_c); % 找到属于当前类的所有样本的索引
    sample_now = length(index_now); % 计算当前类样本个数
    
    data_now = train_all(index_now,1:end-1); % 获得当前类样本矩阵
    dist_now = get_dist(data_now,data_now,sample_now,sample_now); % 计算当前类样本两两距离矩阵（对角线距离最大）
    d_now = mean(mean(dist_now)); % 当前类样本两两平均距离
    
    sample = [sample;sample_now]; % 保存当前类类别数及距离信息
    d = [d;d_now];
    
end%for_i_c

sample_weight = sample_all./sample; % 样本数越多，这个值越小
distance_weight = mean(d)./d; % 样本间平均距离越大，这个值越小
m_vec = sample_weight.*distance_weight; % 每一类的权重

% 赋值
model.s = sample_all;
model.c = c;
model.r = mean(d);
model.m = m_vec;


end%function
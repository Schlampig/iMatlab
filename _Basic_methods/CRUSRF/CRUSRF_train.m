function [forest] = CRUSRF_train(train_all, T, k)

% 训练k均值聚类随机下采样的随机森林算法，两类用
% train_all: 数据集矩阵，一行一个样本，最后一类是类别标记，min(label) = 1
% T： 随机森林树的个数
% k： k均值聚类个数
% forest: 随机森林模型，结构体

% 预处理
label_all = train_all(:,end);
n1 = sum(label_all == min(label_all)); % label数值较小的样本的个数
n2 = length(label_all) - n1;
if n1 <= n2 % 如果n2多数类
    pos_all = train_all(find(label_all == min(label_all)),:);
    neg_all = train_all(find(label_all ~= min(label_all)),:);
else
    pos_all = train_all(find(label_all ~= min(label_all)),:);
    neg_all = train_all(find(label_all == min(label_all)),:);
end%if
if size(pos_all,1) ~=0 % 存在少数类，求不平衡率IR = n/p
    IR = size(neg_all,1)/size(pos_all,1);
else
    IR = 1;
end%if

% 聚类
[neg_index, neg_center]=kmeans(neg_all(:,1:end-1),k);

% 每个类中随机按比例下采样生成新训练集
% p = n/IR = (n1+n2+...+nk)/IR = n1/IR + n2/IR + ... + nk/IR = c1 + c2 + ...+ ck
neg_new = [];
for i=1:k
   cluster_i = neg_all(find(neg_index == i),:); % 当前簇组成的数据集
   n_i = size(cluster_i,1); % 当前簇内样本个数
   c_i = round(n_i/IR); % 当前簇采样样本个数
   index_i = randperm(n_i); % 打乱当前簇样本序号
   neg_new = [neg_new;cluster_i(index_i(1:c_i),:)];
   clear cluster_i; clear n_i; clear c_i; clear index_i
end
train_new = [pos_all;neg_new]; % 采样的负类与原来的正类合并成新的训练集

% 训练
forest = TreeBagger(T,train_new(:,1:end-1),train_new(:,end), 'Method', 'classification');%代入训练

end % function
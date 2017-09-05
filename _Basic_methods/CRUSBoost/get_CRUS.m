function [train_sub] = get_CRUS(train_all, par)

% 按比例ratio随机下采样train_all里的负类样本，生成新训练集train_sub
% train_all, train_sub: 样本矩阵，一行一个样本，最后一列是label
% ratio：下采样比例，介于0与1之间

% 赋值
k = par.k;
ratio = par.ratio;

% 分数据集为正负类
value_label = unique(train_all(:,end));
train_label = train_all(:,end);
if length(value_label) ~= 2   
    disp('Not a binary problem for undersampling!');
else
    if sum(train_label == value_label(1)) >= sum(train_label == value_label(2))
        train_pos = train_all(find(train_label == value_label(2)),:);
        train_neg = train_all(find(train_label == value_label(1)),:);
    else
        train_pos = train_all(find(train_label == value_label(1)),:);
        train_neg = train_all(find(train_label == value_label(2)),:);
    end%if
end%if

% 生成IR
n_pos = size(train_pos,1);
n_neg = size(train_neg,1);
if n_pos == 0
    IR = 1;
else
    IR = n_neg/n_pos - ratio;
    if IR < 1
        IR = 1;
    end%if
end%if

% 聚类
[neg_index, ~] = kmeans(train_neg(:,1:end-1),k);

% 每个类中随机按比例下采样生成新训练集
% p = n/IR = (n1+n2+...+nk)/IR = n1/IR + n2/IR + ... + nk/IR = c1 + c2 + ...+ ck
train_neg_new = [];
for i=1:k
   cluster_i = train_neg(find(neg_index == i),:); % 当前簇组成的数据集
   n_i = size(cluster_i,1); % 当前簇内样本个数
   c_i = round(n_i/IR); % 当前簇采样样本个数
   index_i = randperm(n_i); % 打乱当前簇样本序号
   train_neg_new = [train_neg_new;cluster_i(index_i(1:c_i),:)];
   clear cluster_i; clear n_i; clear c_i; clear index_i
end
train_sub = [train_pos;train_neg_new]; % 采样的负类与原来的正类合并成新的训练集


end % function
function [train_sub] = get_undersample(train_all, ratio)

% 按比例ratio随机下采样train_all里的负类样本，生成新训练集train_sub
% train_all, train_sub: 样本矩阵，一行一个样本，最后一列是label
% ratio： 下采样比例，介于0与1之间

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

% 生成下采样数目
n_pos = size(train_pos,1);
n_neg = size(train_neg,1);
new_n_neg = n_pos*(1 + ratio);
if new_n_neg > n_neg
    new_n_neg = n_neg;
end%if

% 随机下采样
index_neg = randperm(n_neg);
new_train_neg = train_neg(index_neg(1:new_n_neg),:);

% 生成新样本集
train_sub = [new_train_neg; train_pos];

end % function
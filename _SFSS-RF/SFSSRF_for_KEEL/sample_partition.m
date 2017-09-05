function [data_cell] = sample_partition(data_mat, ratio, n_cell)

% 将一个数据集矩阵转化为还有多个cell的数据集胞体，每个cell内正负类样本个数基本平衡
% data_mat:数据集矩阵，一行一个样本，最后一列是label，只能是二分类，label={1,2}
% ratio: 正类样本数*（1+ratio）= 筛选出的负类样本数
% n_cell:生成的胞体个数
% data_cell:一个1*n_cell的胞体，每个cell存放sub数据集(矩阵)

data_pos = data_mat(find(data_mat(:,end)==2),:);% 正类矩阵
data_neg = data_mat(find(data_mat(:,end)==1),:);% 负类矩阵
n_pos = size(data_pos,1);
n_neg = size(data_neg,1);

if n_pos > n_neg %正类比负类多，交换两类
    data_temp = data_pos;
    data_pos = data_neg;
    data_neg = data_temp;
end

if n_pos* (1+ratio) > n_neg % 不平衡率低，重置ratio
    ratio = n_neg/n_pos - 1;
end

n_neg_new = floor(n_pos*(1+ratio));

r = 1; %记录胞体个数
for i_cell = 1:n_cell
    neg_index = randperm(n_neg);
    new_neg_index = neg_index(1:n_neg_new);
    data_cell{r} = [data_neg(new_neg_index,:); data_pos];
    r = r + 1;
end%for_i_cell

end % function
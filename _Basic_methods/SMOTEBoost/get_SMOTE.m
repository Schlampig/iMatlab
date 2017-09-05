function [train_sub, k, r] = get_SMOTE(train_all, par)

% 使用SMOTE上采样train_all里的正类样本，生成新训练集train_sub
% train_all, train_sub: 样本矩阵，一行一个样本，最后一列是label

% 赋值
k = par.k; % 近邻个数
r = par.r; % 连线生成新样本数

% 生成正负类数据集及标号集
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
data_pos = train_pos(:,1:end-1);
n_pos = size(train_pos,1);
n_neg = size(train_neg,1);

% 判断采样是否合理并适当削减r与k
if n_pos == 0
    disp('No positive samples!');
elseif k+1 > n_pos
    k = n_pos - 1;
else
    while k > 1 % 让k减到足够小
        while r > 1 % 让r减到足够小
            if n_pos + n_pos*k*r >= n_neg
                r = r - 1;
            else
                break;
            end % if
        end % while_r
        if n_pos + n_pos*k*r >= n_neg
            k = k - 1;
        else
            break;
        end % if
    end % while_k
end % if

% 求距离矩阵
[~,i_neighbor] = pdist2(data_pos,data_pos,'euclidean','Smallest',k+1); % i_neighbor是k*N的矩阵，第n列是第n个样本的k近邻的index，但第一行是样本与自己的距离，需要去掉
i_neighbor = i_neighbor(2:end,:)'; % N*k列的index矩阵

% 上采样
new_pos_mat = [];
for i = 1:n_pos
    now_sample = data_pos(i,:); % 取出当前正类样本
    for j = 1:k
        new_sample_mat = get_new_pos(now_sample, data_pos(i_neighbor(i,j),:), r);
        new_pos_mat = [new_pos_mat;new_sample_mat];
        clear new_sample_mat;
    end%for_j
end%for_i

% 与原来的正、负类合并成新训练集
train_sub = [train_neg;train_pos;[new_pos_mat,train_pos(1,end)*ones(size(new_pos_mat,1),1)]]; 

end % function



function [neighbors] = get_new_pos(sample, neighbor, r)
% 在自己与一个邻居之间采样r个点
% sample与neighbor都是行向量
    neighbors = [];
    for i_r = 1:r
        neighbors = [neighbors; sample + (sample - neighbor).* rand(size(sample))];
    end%for_i_r
end%function


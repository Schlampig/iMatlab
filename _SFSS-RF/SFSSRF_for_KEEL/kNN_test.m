function [label_pre] = kNN_test(test_all, train_all, c, k, tag)


% kNN的测试过程，需要训练数据参与
% train_all：一行一个样本，最后一列是类别标记
% test_all：一行一个样本，最后一列是类别标记
% k：近邻个数
% c: 类别总数
% tag: 选择度量策略
% label_pre: 预测类别标记

% 预处理
test_num = size(test_all,1); % 测试样本总数
label_train = train_all(:,end); % 训练样本类别标记

label_pre = [];
for i_test = 1:test_num
    if tag == 1 % 选择距离度量策略
        vec_dist = pdist2(train_all(:,1:end-1),test_all(i_test,1:end-1),'jaccard');
    elseif tag == 0
        vec_dist = pdist2(train_all(:,1:end-1),test_all(i_test,1:end-1),'euclidean');
    end%if
    mat_dist = [vec_dist,label_train]; % 第一列是候选样本的距离，第二列是候选样本的类别标记
    pre_now = get_k_neighbor(mat_dist,c,k); % 根据训练时得到的数据和类别标记预测当前测试样本的类别标记
    label_pre = [label_pre;pre_now];
end%for_i_test

end%function



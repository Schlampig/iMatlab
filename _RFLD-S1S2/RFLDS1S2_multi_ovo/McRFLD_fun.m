function [pre_label] = McRFLD_fun(train_all, test_all, par)

% 多分类训练、测试函数
% train_all, test_all:数据矩阵，一行一个样本，最后一列是label
% par:结构体，存各种参数，调用方式为par.X
% new_par: 返回的新参数结构体
% pre_label：对当前测试集样本类别标记的预测，一个列向量

% 选择模型
modelname = par.modelname;

% 训练
train_label = train_all(:,end);
c_num = length(unique(train_label));
r = 1;
for i = 1:(c_num-1)
    for j = (i+1):c_num
        n_i = length(find(train_label == i));
        n_j = length(find(train_label == j));
        if n_i > n_j
            poslabel = j;
            neglabel = i;
        else
            poslabel = i;
            neglabel = j;
        end % if
        fea_pos = train_all(find(train_label == poslabel),:);
        fea_neg = train_all(find(train_label == neglabel),:);
        fea_pos(:,end) = 1;
        fea_neg(:,end) = 0;
        fea_train = [fea_pos;fea_neg];
        [clf] = eval([modelname,'_train(fea_train, par)']); %利用第i与第j类样本训练当前分类器
        clf.poslabel = poslabel;
        clf.neglabel = neglabel;
        learner{r} = clf;
        r = r+1;
        clear poslabel;clear neglabel;
        clear fea_pos;clear fea_neg; 
        clear fea_train;
    end % for_j
end% for_i

% 测试
vote_mat = [];
for i_test = 1:r-1
    clf = learner{i_test};
    vote_vec = eval([modelname,'_test(test_all, clf)']); %当前分类器对所有测试集样本的预测，返回的是一个列向量
    vote_vec(find(vote_vec == 1)) = clf.poslabel;
    vote_vec(find(vote_vec == 0)) = clf.neglabel;
    vote_mat = [vote_mat, vote_vec];
    clear clf;
end % for_i_test
pre_label = get_aggregate(vote_mat);   
        
end % function
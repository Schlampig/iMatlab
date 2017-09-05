function [res] = ABRS_fun(train_all, test_all, par)


% ABRS_svm的主框架，目前只适用于二分类问题，正类标记为2，负类为1
% train_all/test_all： 训练/测试矩阵，一行一个样本，最后一列是lable，min(label)=1
% par：记录传入的参数，其中par.model用于选择分类器。

% 预处理
IR = length(find(train_all(:,end)==2))/length(find(train_all(:,end)==1));%计算反向不平衡率
neg_all = train_all(find(train_all(:,end)==1),:);% 负类数据集矩阵
pos_all = train_all(find(train_all(:,end)==2),:);% 正类数据集矩阵
[num_r, num_c] = size(neg_all);
[r_slice_mat, c_slice_mat] = get_slice(par.Ts, par.Tf, num_r, num_c-1, IR, par.Rc);

% 训练
k = 1;
for i = 1:par.Ts
    for j = 1:par.Tf
        train_now = [pos_all(:,[c_slice_mat(k,:),num_c]); neg_all(r_slice_mat(k,:),[c_slice_mat(k,:),num_c])]; % train_now，子数据集，一行一个样本，最后一列是label
        option=svmsmoset('MaxIter',par.maxtime);
        model(k).svm = svmtrain(train_now(:,1:end-1),train_now(:,end),'kernel_function','rbf','rbf_sigma',par.sigma,'method','SMO','boxconstraint',par.C,'SMO_OPTS',option);
        k = k + 1;
        clear train_now;
    end%for_j
end%for_i

% 测试
vote_mat = [];%行数是测试样本个数，列数是基分类器个数，第c列是第c个基分类器对当前所有测试样本的预测
for c = 1:k-1
    vote_now = svmclassify(model(c).svm,test_all(:,c_slice_mat(c,:)));
    vote_mat = [vote_mat,vote_now];
end%for_c
label_pre = get_aggregate(vote_mat);%预测类别标记
label_test = test_all(:,end);%真实类别标记

% 度量
% 统计一轮的结果
res = get_binary_evaluate(label_pre,label_test);

end%function
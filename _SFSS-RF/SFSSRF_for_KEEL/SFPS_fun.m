function [vec_res, name, weight] = SFPS_fun(train_all, test_all, par)


% 使用分块策略的框架（Samples & Featrues Partition Strategy），目前只适用于二分类问题
% train_all/test_all： 训练/测试矩阵，一行一个样本，最后一列是lable，min(label)=1
% par：记录传入的参数，其中par.model用于选择分类器。
% model：用于返回运行数据的结构体。


% 初始化参数
n_class = 2;
n_sample = par.n_sample;

% 生成sub数据集
[train_cell] = sample_partition(train_all, par.ratio, par.n_sample); % sample_parttition给样本分片（输入是矩阵），fea_partition给特征分片（输入是胞体）,返回值都带label的
[train_sub, n_fea] = fea_partition(train_cell, par); 

% 分块训练
for i_s = 1:n_sample
    for i_f = 1:n_fea
        [clf{i_s,i_f}, name] = model_train(train_sub{i_s,i_f}, par); % train_sub是n_sample行n_fea列的胞体(cell)
    end%for_i_f
end%for_i_s
name = strcat(name,'_ratio_',num2str(par.ratio),'_s&f',num2str(n_sample),'x',num2str(n_fea)); % 现实行列数

% 分块验证
validate_label = train_all(:,end);
for j_f = 1:n_fea
    [validate_now,~] = fea_partition({train_all}, par); % 返回的validata_sub是行为1，列为n_fea的胞体(cell)
    for j_s = 1:n_sample   
        pre_label = model_predict(validate_now{1,j_f}, clf{j_s,j_f}, par.model); % predict返回每个算法的预测能力权重
        res_validate{j_s,j_f} = get_binary_evaluate(pre_label, validate_label); % res_validate{j_s,j_f}是个行向量
        clear pre_label;
    end%for_j_s
end%for_j_f

% 获取分块模型置信度
weight = zeros(n_sample, n_fea);
for w_s = 1:n_sample
    for w_f = 1:n_fea   
        weight(w_s,w_f) = sum(res_validate{w_s,w_f}.* par.target)/length(find(par.target ~= 0)); %以target指定位置的indicator为置信指标
    end%for_i_f
end%for_i_s
weight = (weight - min(min(weight)))./ (max(max(weight)) - min(min(weight)));

% 分块测试
score_mat = [];
[test_now,~] = fea_partition({test_all}, par);
for k_s = 1:n_sample
    for k_f = 1:n_fea
        pre_label = model_predict(test_now{1,k_f}, clf{k_s,k_f}, par.model); %pre.lable里面是一个列向量，长度是test样本的总数
        score_mat = [score_mat, [pre_label; weight(k_s,k_f)] ];%对应分类器的置信度放在最后一行
        clear pre_label;
    end%for_k_f
end%for_k_s
final_pre_vec = get_final_pre(score_mat, n_class); %得到最终预测类别列向量
true_test_label = test_all(:,end); %真实类别标记

% 评估
vec_res = get_binary_evaluate(final_pre_vec, true_test_label);

end%function
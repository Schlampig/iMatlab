function [res] = Ada_test(test_all, method, par)

% 测试AdaBoost的函数，这个版本只能处理两类分类问题
% test_all：数据集矩阵，一行一个样本，最后一列是Label

T = par.T; % 迭代数=基分类器个数
c = length(unique(test_all(:,end))); % 总类数
sub_label = [];
a = [];
for i = 1:T     
    temp_pre = model_predict(test_all, method(i).clf, par);
    sub_label = [sub_label, temp_pre]; 
    a = [a, method(i).a];    
end%for_i

pre_label = [];
for j = 1:size(sub_label,1)
    pre_label = [pre_label; get_vote_pre(sub_label(j,:), a, c)];
end%for_j

[res] = get_binary_evaluate(pre_label, test_all(:,end));   

end % function
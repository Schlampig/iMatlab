function BERL_main(dataset_name, data_index,ktimes)

%消解随机线性分类模型（Boundary Eliminate Random Linear）

% dataset_name： 存放数据集的集合的名称
% data_index： 数据集序号
% ktimes: 迭代轮数，一般为5或10轮（根据数据集而定）


% 预处理
load(dataset_name);
dataname =  strcat('BERL_',Imbalanced_data{data_index,1});%转存的文件名
final_res = zeros(ktimes+2,8);%记录ktimes轮结果的矩阵,倒数第二行存均值，最后一行存std，每一列分别是TP,FP,TN,FN,acc,均值acc，gm,auc=

% 训练与测试
for i_cv = 1:ktimes
   % 获得数据集
   train_all = Imbalanced_data{data_index,3}{i_cv,1};
   test_all = Imbalanced_data{data_index,3}{i_cv,2}; 
   % 训练
   [model] = BERL_train(train_all);
   % 测试
   [vec_res] = BERL_test(test_all,model);
   %统计一轮的结果
   final_res(i_cv,:) = vec_res;    
end%for_i_cv

% 统计结果
final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
final_res(ktimes+2,:) = std(final_res(1:ktimes,:));

% 保存结果
save([dataname,'.mat'],'final_res');


end
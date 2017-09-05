function kNN_main(dataset_name, data_index, ktimes, k)

% 多分类kNN模型

% dataset_name： 存放数据集的集合的名称
% data_index： 数据集序号
% ktimes: 迭代轮数，一般为5或10轮（根据数据集而定）
% k：近邻个数

% 预处理
load([dataset_name,'.mat']);
file_name = eval([dataset_name,'{',num2str(data_index),',1}']);
dataname =  strcat('kNN_',file_name,'_k',num2str(k));%转存的文件名
final_res = zeros(ktimes+2,8);%记录ktimes轮结果的矩阵,倒数第二行存均值，最后一行存std，每一列分别是TP,FP,TN,FN,acc,均值acc，gm,auc

% 训练与测试
for i_cv = 1:ktimes    
   % 获得数据集（最后一列为类别标记）
   if strcmp(dataset_name,'KEEL')   
       train_all = eval([dataset_name,'{',num2str(data_index),',3}{',num2str(i_cv),',1}']);
       test_all = eval([dataset_name,'{',num2str(data_index),',3}{',num2str(i_cv),',2}']);
       train_all(:,end) = train_all(:,end)+1;
       test_all(:,end) = test_all(:,end)+1;
   else
       train_all = eval([dataset_name,'{',num2str(data_index),',2}{',num2str(i_cv),',1}']);
       test_all = eval([dataset_name,'{',num2str(data_index),',2}{',num2str(i_cv),',2}']);
   end%if
   
   % 测试
   [vec_res] = kNN_test(test_all, train_all, k);
   %统计一轮的结果
   final_res(i_cv,:) = vec_res;    
end%for_i_cv

% 统计结果
final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
final_res(ktimes+2,:) = std(final_res(1:ktimes,:));

% 保存结果
save([dataname,'.mat'],'final_res');


end % function
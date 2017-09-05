function BEK2PILD_main(dataset_name, data_index, ktimes, par)

%核化BEPILD模型，包含正则化选择，及边界判断，和K1不同，边界也是核化的

% dataset_name： 存放数据集的集合的名称
% data_index： 数据集序号
% ktimes: 迭代轮数，一般为5或10轮（根据数据集而定）
% dp_index:用来选择生成的dp（理想label）值，代入dp_Gernerate()
% num_reg: 正则化权重参数，标量， reg=0即不加扰动，reg越大扰动越大

% 预处理
load(dataset_name);
dataname =  strcat('BEK2PILD_',Imbalanced_data{data_index,1},'_dp',num2str(par.dp),'_reg',num2str(par.reg),'_',par.ktype,'_',num2str(par.kpara));%转存的文件名
final_res = zeros(ktimes+2,8);%记录ktimes轮结果的矩阵,倒数第二行存均值，最后一行存std，每一列分别是TP,FP,TN,FN,acc,均值acc，gm,auc=

% 训练与测试
for i_cv = 1:ktimes
   % 获得数据集
   train_all = Imbalanced_data{data_index,3}{i_cv,1};
   test_all = Imbalanced_data{data_index,3}{i_cv,2}; 
   % 训练
   [model,flag] = BEK2PILD_train(train_all,par);
   % 测试
   if flag == 1 % 可分情形，不需要使用启发式算法
       [vec_res] = PILD_test(test_all,model);
   elseif flag == 0 %重叠情形，需要使用启发式算法
       [vec_res] = BEPILD_test(test_all,model);
   end%if
   %统计一轮的结果
   final_res(i_cv,:) = vec_res;    
end%for_i_cv

% 统计结果
final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
final_res(ktimes+2,:) = std(final_res(1:ktimes,:));

% 保存结果
save([dataname,'.mat'],'final_res');


end
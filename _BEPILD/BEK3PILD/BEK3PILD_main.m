function BEK3PILD_main(dataset_name, data_index,ktimes,Par)

% BEK3PILD模型，利用经验核映射将所有样本先映射到核空间，再在核空间做普通的BEPILD操作

% dataset_name： 存放数据集的集合的名称
% data_index： 数据集序号
% ktimes: 迭代轮数，一般为5或10轮（根据数据集而定）
% dp_index:用来选择生成的dp（理想label）值，代入dp_Gernerate()
% num_reg: 正则化权重参数，标量， reg=0即不加扰动，reg越大扰动越大

% 预处理
ker_type = Par.ker_type;
ker_par = Par.ker_par;
load(dataset_name);
dataname =  strcat('BEK3PILD_',Imbalanced_data{data_index,1},'_dp',num2str(Par.dp),'_reg',num2str(Par.reg),'_',ker_type,num2str(ker_par));%转存的文件名
final_res = zeros(ktimes+2,8);%记录ktimes轮结果的矩阵,倒数第二行存均值，最后一行存std，每一列分别是TP,FP,TN,FN,acc,均值acc，gm,auc

% 训练与测试
for i_cv = 1:ktimes
   
   % 利用经验核映射获得核空间数据集
   train_data = Imbalanced_data{data_index,3}{i_cv,1};
   test_data = Imbalanced_data{data_index,3}{i_cv,2}; 
   [ker_train, ker_test] = gen_empirical_ker_data(train_data(:,1:end-1), test_data(:,1:end-1), ker_type, ker_par); % ker_test = rxN2
   train_all = [ker_train',train_data(:,end)]; % N1x(r+1)
   test_all = [ker_test',test_data(:,end)];% N2x(r+1)

   % 训练
   [model,flag] = BEPILD_train(train_all, Par.dp, Par.reg);
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


end%function
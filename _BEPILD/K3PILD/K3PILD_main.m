function K3PILD_main(dataset_name, data_index, ktimes, Par)

%计算不平衡数据集的解析伪逆算法（不需要迭代）

%dp_index:用来选择生成的dp（理想label）是怎样的

%初始化
ker_type = Par.ker_type;
ker_par = Par.ker_par;
dp_index = Par.dp;

load(dataset_name);
dataname =  strcat('K3PILD_dp_',num2str(dp_index),'_',ker_type,num2str(ker_par),'_',Imbalanced_data{data_index,1});%转存的文件名
final_res = zeros(ktimes+2,8);%记录ktimes轮结果的矩阵,倒数第二行存均值，最后一行存std，每一列分别是TP,FP,TN,FN,acc,均值acc，gm,auc=
ir = Imbalanced_data{data_index,2};
for i_cv = 1:ktimes
   % 利用经验核映射获得核空间数据集
   train_data = Imbalanced_data{data_index,3}{i_cv,1};
   test_data = Imbalanced_data{data_index,3}{i_cv,2}; 
   [ker_train, ker_test] = gen_empirical_ker_data(train_data(:,1:end-1), test_data(:,1:end-1), ker_type, ker_par); % ker_test = rxN2
   train_all = [ker_train',train_data(:,end)]; % N1x(r+1)
   test_all = [ker_test',test_data(:,end)];% N2x(r+1) 
   
   [w,w0] = PILD_train(train_all,dp_index);
   [vec_res] = PILD_test(test_all,w,w0);
   final_res(i_cv,:) = vec_res;  
end%for_i_cv
final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
final_res(ktimes+2,:) = std(final_res(1:ktimes,:));

save([dataname,'.mat'],'final_res');


end
function newMFLD_main(dataset_name,data_index,ktimes,dp,reg,k,c)

%计算不平衡数据集的正则化Fisher算法（不需要迭代）


load([dataset_name,'.mat']);
file_name = eval([dataset_name,'{',num2str(data_index),',1}']);
dataname =  strcat('newMFLD','_dp',num2str(dp),'_reg',num2str(reg),'_c',num2str(c),'_k',num2str(k),'_',file_name);%转存的文件名
final_res = zeros(ktimes+2,8);%记录ktimes轮结果的矩阵,倒数第二行存均值，最后一行存std，每一列分别是TP,FP,TN,FN,acc,均值acc，gm,auc=

for i_cv = 1:ktimes
   train_all = eval([dataset_name,'{',num2str(data_index),',3}{',num2str(i_cv),',1}']);
   test_all = eval([dataset_name,'{',num2str(data_index),',3}{',num2str(i_cv),',2}']);
   
   [w,w0] = newMFLD_train(train_all,dp,reg,k,c);
   [vec_res] = PILD_test(test_all,w,w0);
   final_res(i_cv,:) = vec_res;  
   
end%for_i_cv
final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
final_res(ktimes+2,:) = std(final_res(1:ktimes,:));

save([dataname,'.mat'],'final_res');


end
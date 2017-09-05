function LIkNN_main(data_index,ktimes,k,inf)

%计算不平衡数据集的LIkNN算法

load Imbalanced_data.mat;
dataname =  strcat('LIkNN_',Imbalanced_data{data_index,1},'_Neighbor_',num2str(k),'_Inf_',num2str(inf));%转存的文件名
final_res = zeros(ktimes+2,8);%记录ktimes轮结果的矩阵，倒数第二行存均值，最后一行std，每一列分别是TP,FP,TN,FN,acc,均值acc，gm,auc

for i_cv = 1:ktimes
   train_all = Imbalanced_data{data_index,3}{i_cv,1};
   test_all = Imbalanced_data{data_index,3}{i_cv,2}; 
   
   [vec_res] = LIkNN_test(train_all,test_all,k,inf);
   final_res(i_cv,:) = vec_res;
end%for_i_cv
final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
final_res(ktimes+2,:) = std(final_res(1:ktimes,:));

save([dataname,'.mat'],'final_res');

end
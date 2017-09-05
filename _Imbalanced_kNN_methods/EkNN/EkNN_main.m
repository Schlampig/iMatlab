function EkNN_main(data_index,ktimes,k)

%计算不平衡数据集的PNN算法

load Imbalanced_data.mat;
dataname =  strcat('EkNN_',Imbalanced_data{data_index,1},'_k_',num2str(k));%转存的文件名
final_res = zeros(ktimes+2,8);%记录ktimes轮结果的矩阵，倒数第二行存均值，最后一行std，每一列分别是TP,FP,TN,FN,acc,均值acc，gm,auc

for i_cv = 1:ktimes
   train_all = Imbalanced_data{data_index,3}{i_cv,1};
   test_all = Imbalanced_data{data_index,3}{i_cv,2}; 
   IR = Imbalanced_data{data_index,2};
   fneg_global = IR/(1+IR);
   z = 0.84;%z = [3.09;2.58;2.33;1.65;1.28;0.84;0.25]
   delta = Cal_threshold(z,fneg_global,size(train_all,1));
   [train_all_new] = PPIgenerate(z,delta,train_all);   
   
   [vec_res] = EkNN_test(train_all_new,test_all,k);
   final_res(i_cv,:) = vec_res;
end%for_i_cv
final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
final_res(ktimes+2,:) = std(final_res(1:ktimes,:));

save([dataname,'.mat'],'final_res');

end
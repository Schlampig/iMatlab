function PILDC_main(data_index,ktimes,dp_index)

%计算不平衡数据集的解析伪逆算法（不需要迭代）

%dp_index:用来选择生成的dp（理想label）是怎样的

load Imbalanced_data.mat;
dataname =  strcat('PILDC_dp_',num2str(dp_index),'_',Imbalanced_data{data_index,1});%转存的文件名
final_res = zeros(ktimes+2,8);%记录ktimes轮结果的矩阵,倒数第二行存均值，最后一行存std，每一列分别是TP,FP,TN,FN,acc,均值acc，gm,auc=aa
ir = Imbalanced_data{data_index,2};
for i_cv = 1:ktimes
   train_all = Imbalanced_data{data_index,3}{i_cv,1};
   test_all = Imbalanced_data{data_index,3}{i_cv,2}; 
   
   [w,w0,bpos,bneg,candi_dis_pos,candi_dis_neg] = PILDC_train(train_all,dp_index);
   [vec_res] = PILDC_test(test_all,w,w0,bpos,bneg,candi_dis_pos,candi_dis_neg);
   final_res(i_cv,:) = vec_res;  
end%for_i_cv
final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
final_res(ktimes+2,:) = std(final_res(1:ktimes,:));

save([dataname,'.mat'],'final_res');


end
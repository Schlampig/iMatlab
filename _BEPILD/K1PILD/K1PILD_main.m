function K1PILD_main(dataset_name, data_index, ktimes, par)

%采用隐性核的解析伪逆算法（不需要迭代）

%dp_index:用来选择生成的dp（理想label）是怎样的

% 赋值
dp_index = par.dp;
num_reg = par.reg;
ker_type = par.ktype;
ker_par = par.kpara;

load(dataset_name);
dataname =  strcat('K1PILD_dp_',num2str(par.dp),'_reg_',num2str(par.reg),'_',par.ktype,num2str(par.kpara),Imbalanced_data{data_index,1});%转存的文件名
final_res = zeros(ktimes+2,8);%记录ktimes轮结果的矩阵,倒数第二行存均值，最后一行存std，每一列分别是TP,FP,TN,FN,acc,均值acc，gm,auc=

for i_cv = 1:ktimes
   train_all = Imbalanced_data{data_index,3}{i_cv,1};
   test_all = Imbalanced_data{data_index,3}{i_cv,2}; 
   
   [w,w0] = K1PILD_train(train_all,par);
   [vec_res] = PILD_test(test_all,w,w0);
   final_res(i_cv,:) = vec_res;  
end%for_i_cv
final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
final_res(ktimes+2,:) = std(final_res(1:ktimes,:));

save([dataname,'.mat'],'final_res');


end
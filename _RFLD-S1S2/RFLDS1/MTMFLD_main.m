function MTMFLD_main(dataset_name,data_index,ktimes,dp,reg,c,theta,k)

% 计算不平衡数据集的多阈值Fisher算法（不需要迭代，但需要选择使用哪一个w0）
% theta:选择阈值的tag，一共有1-11个阈值可选，但一般实验中只取2-11号
% c：惩罚因子，cSw+(1-c)Slw
% k：计算Slw时需要的近邻因子

load([dataset_name,'.mat']);
file_name = eval([dataset_name,'{',num2str(data_index),',1}']);
dataname =  strcat('MTMFLD_reg_',num2str(reg),'_dp_',num2str(dp),'_c_',num2str(c),'_k_',num2str(k),'_',file_name);%转存的文件名

final_res = [];%记录每个theat的平均结果
for i_theta = 1:length(theta)
%     subdataname =  strcat('MTMFLD_dp',num2str(dp),'_reg',num2str(reg),'_theta',num2str(theta(i_theta)),'_c',num2str(c),'_k',num2str(k),'_',file_name);%转存的文件名
    sub_res = zeros(ktimes+2,8);%记录ktimes轮结果的矩阵,倒数第二行存均值，最后一行存std，每一列分别是TP,FP,TN,FN,acc,均值acc，gm,auc=
    for i_cv = 1:ktimes
       train_all = eval([dataset_name,'{',num2str(data_index),',3}{',num2str(i_cv),',1}']);
       test_all = eval([dataset_name,'{',num2str(data_index),',3}{',num2str(i_cv),',2}']); 

       [w,w0] = MTMFLD_train(train_all,dp,reg,c,theta(i_theta),k);
       [vec_res] = PILD_test(test_all,w,w0);
       sub_res(i_cv,:) = vec_res;     
    end%for_i_cv
    sub_res(ktimes+1,:) = mean(sub_res(1:ktimes,:));
    sub_res(ktimes+2,:) = std(sub_res(1:ktimes,:));
%     save([subdataname,'.mat'],'sub_res');
    
    final_res = [final_res;mean(sub_res(1:ktimes,:))];
%     clear sub_res; clear subdataname;
    
end%for_i_theta

final_res = [final_res; mean(final_res)];
final_res = [final_res; max(final_res)];%与其他算法相比，MTMFLD多出这一行
final_res = [final_res; std(final_res)];

save([dataname,'.mat'],'final_res');

end
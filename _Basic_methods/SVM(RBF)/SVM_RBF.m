function SVM_RBF(dataset_name, data_index, ktimes, C, sigma)

%使用RBF核测量不平衡数据集的SVM分类器。
%超出范围的设置没有报错机制，看着办。
%ktimes：MCCV迭代次数（1,2,3,...,10）
%C:松弛因子
%sigma：核径

% 预处理
load([dataset_name,'.mat']);
file_name = eval([dataset_name,'{',num2str(data_index),',1}']);
dataname =  strcat('SVMrbf_',file_name,'_C',num2str(C),'_sigma',num2str(sigma));%转存的文件名
final_res = zeros(ktimes+2,8);%记录ktimes轮结果的矩阵,倒数第二行存均值，最后一行存std，每一列分别是TP,FP,TN,FN,acc,均值acc，gm,auc=

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
    c = max(train_all(:,end)); % 总类数
    
    % 训练
    option=svmsmoset('MaxIter',50000);
    IBSVM.rbf = svmtrain(train_all(:,1:end-1),train_all(:,end),'kernel_function','rbf','rbf_sigma',sigma,'method','SMO','boxconstraint',C,'SMO_OPTS',option);%代入训练
   
    % 测试
    label_pre = svmclassify(IBSVM.rbf,test_all(:,1:end-1));  
    label_test = test_all(:,end);
    
    % 统计一轮的结果
    final_res(i_cv,:) = get_binary_evaluate(label_pre,label_test);

end%for_i_cv

final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
final_res(ktimes+2,:) = std(final_res(1:ktimes,:));

save([dataname,'.mat'],'final_res');

            
end
            
            


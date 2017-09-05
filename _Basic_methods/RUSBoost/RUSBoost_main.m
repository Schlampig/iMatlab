function RUSBoost_main(dataset_name, data_index, par)

% RUSBoost的主函数
% 超出范围的设置没有报错机制，看着办。
% ktimes：MCCV迭代次数（1,2,3,...,10）
% par:存放各模型需要参数的结构体

% 预处理
load([dataset_name,'.mat']);
file_name = eval([dataset_name,'{',num2str(data_index),',1}']);
final_res = zeros(par.ktimes+2,8);%记录ktimes轮结果的矩阵,倒数第二行存均值，最后一行存std，每一列分别是TP,FP,TN,FN,acc,均值acc，gm,auc=

% 学习
for i_cv = 1:par.ktimes    
    % 获得数据集（最后一列为类别标记）
    if strcmp(dataset_name,'KEEL')   
        train_all = eval([dataset_name,'{',num2str(data_index),',3}{',num2str(i_cv),',1}']);
        test_all = eval([dataset_name,'{',num2str(data_index),',3}{',num2str(i_cv),',2}']);
        train_all(:,end) = get_new_label(train_all(:,end));
        test_all(:,end) = get_new_label(test_all(:,end));
    else
        train_all = eval([dataset_name,'{',num2str(data_index),',2}{',num2str(i_cv),',1}']);
        test_all = eval([dataset_name,'{',num2str(data_index),',2}{',num2str(i_cv),',2}']);
    end%if

    % 训练&测试&记录
    [method, clf_name] = RUSBoost_train(train_all, par);
    final_res(i_cv,:) = Ada_test(test_all, method, par);
    
end%for_i_cv

final_res(par.ktimes+1,:) = mean(final_res(1:par.ktimes,:));
final_res(par.ktimes+2,:) = std(final_res(1:par.ktimes,:));
final_name = strcat('RUSBoost_',file_name,'_iter',num2str(par.T),'_',clf_name);

save([final_name,'.mat'],'final_res');

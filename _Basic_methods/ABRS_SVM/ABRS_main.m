function ABRS_main(dataset_name, data_index, par)

% 调用采取样本与特征投票策略的分类器的主方法
% 超出范围的设置没有报错机制，看着办。
% ktimes：MCCV迭代次数（1,2,3,...,10）
% par:存放各模型需要参数的结构体


% 预处理
load([dataset_name,'.mat']);
file_name = eval([dataset_name,'{',num2str(data_index),',1}']);
dataname =  strcat('ABRS_SVM_',file_name,'_ts&tf',num2str(par.Ts),'&',num2str(par.Tf),'_rf',num2str(par.Rc),'_C',num2str(par.C),'_sigma',num2str(par.sigma));%转存的文件名
final_res = zeros(par.ktimes+2,8);%记录ktimes轮结果的矩阵,倒数第二行存均值，最后一行存std，每一列分别是TPR,TNR,PPV,F1,Acc,MAcc,GM,0.5(Acc+MAcc)

% 训练与测试
for i_cv = 1:par.ktimes    
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

    % 训练&测试
        [vec_res] = ABRS_fun(train_all, test_all, par);
   
    %统计一轮的结果
    final_res(i_cv,:) = vec_res;  
end%for_i_cv

final_res(par.ktimes+1,:) = mean(final_res(1:par.ktimes,:));
final_res(par.ktimes+2,:) = std(final_res(1:par.ktimes,:));

save([dataname,'.mat'],'final_res');
            
end % function
            
            


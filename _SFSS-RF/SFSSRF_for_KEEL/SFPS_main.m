function SFPS_main(dataset_name, data_index, par)

% 调用采取样本与特征投票策略的分类器的主方法
% 超出范围的设置没有报错机制，看着办。
% ktimes：MCCV迭代次数（1,2,3,...,10）
% par:存放各模型需要参数的结构体


% 预处理
load([dataset_name,'.mat']);
file_name = eval([dataset_name,'{',num2str(data_index),',1}']);
final_res = zeros(par.ktimes+2,8);%记录ktimes轮结果的矩阵,倒数第二行存均值，最后一行存std，每一列分别是TP,FP,TN,FN,acc,均值acc，gm,auc=

r_w = 1;%初始化cell的计数
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
        [vec_res, name, w] = SFPS_fun(train_all, test_all, par);
        dataname =  strcat('SFPS_',file_name,'_',name,'_w&s_',num2str(par.window),'&',num2str(par.step));%转存的文件名 
   
    %统计一轮的结果
    final_res(i_cv,:) = vec_res;  
    w_all{1,r_w} = [w; mean(w)];
    r_w = r_w + 1;
end%for_i_cv

final_res(par.ktimes+1,:) = mean(final_res(1:par.ktimes,:));
final_res(par.ktimes+2,:) = std(final_res(1:par.ktimes,:));

save([dataname,'.mat'],'final_res', 'w_all');
            
end
            
            


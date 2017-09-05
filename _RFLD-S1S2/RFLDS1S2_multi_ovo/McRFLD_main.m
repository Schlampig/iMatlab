function McRFLD_main(par)

% 根据设置的par调用数据集进行学习的主函数

% 赋值
dataset_name = par.dataname;
data_index = par.fileindex;
ktimes = par.ktimes; % iterations of cross validation

% 载入
load([dataset_name,'.mat']);
file_name = eval([dataset_name,'{',num2str(data_index),',1}']);
final_res = [];%记录ktimes轮结果的矩阵,倒数第二行存均值，最后一行存std，每一列分别是macro tpr，macro tnr，ppv，f1,acc,macc，gm,0.5*(acc+macc)

% 交叉验证
for i_cv = 1:ktimes
   % 获得数据集
   train_all = eval([dataset_name,'{',num2str(data_index),',2}{',num2str(i_cv),',1}']);
   test_all = eval([dataset_name,'{',num2str(data_index),',2}{',num2str(i_cv),',2}']);
   train_all = get_preprocess(train_all);
   test_all = get_preprocess(test_all);
   
   % 多类学习
   [pre_label] = McRFLD_fun(train_all, test_all, par);
   % 评估
   vec_res = get_multi_evaluate(test_all(:,end), pre_label);
   
   %统计一轮的结果
   final_res = [final_res;vec_res];    
end%for_i_cv

% 统计CV平均结果
final_res = [final_res; mean(final_res)];
final_res = [final_res;std(final_res(1:end-1,:))];

% 保存结果
parname = get_parname(par); % 获得当前模型超参数配置信息字符串
final_name = strcat('Mc_', par.modelname, parname, file_name);%转存的文件名
save(['res_data\',final_name,'.mat'],'final_res');

end % function


function [new_data] = get_preprocess(old_data)
% 对数据集预处理，包括规范label的值，以及归一化数据
    old_fea = old_data(:,1:end-1);
    % 归一化
    new_fea = old_fea ./repmat(max(old_fea),size(old_fea,1),1); % data/max(data)而非min-max，为了避免归一化后数据出现0
%     % 不归一化
%     new_fea = old_fea;
    new_gnd = normal_label(old_data(:,end));
    new_data = [new_fea, new_gnd];
end%function


function [new_label] = normal_label(old_label)
% 把old_label的值保序变到自然数区间
    class_distribute = unique(old_label);
    c = length(class_distribute);%总类别数
    new_label = old_label;
    for i_c = 1:c
        new_label(find(old_label == class_distribute(i_c))) = i_c;
    end%for_i_c
end % function


function [par_string] = get_parname(par)
% 把参数的值串成一个字符串
    names = fieldnames(par);
    par_string = '_';
    for i = 1: length(names)
        i_name = names{i};
        i_value = getfield(par,i_name);
        par_string = strcat(par_string,i_name,num2str(i_value),'_');
    end%for_i
end% function
function get_holdout_kfcv(name, k_out, k_in)

% 输入：一个数据集结构体d，fea是一行一个样本的数据集矩阵，gnd是对应的label向量。
%       k_out,k_in分别管外层与内层的折数。
%       name是数据集名字
% 输出：一个cell，第一列折数名称，第二列内部分训练测试，第三列holdout。

% 预处理
d = load([name,'.mat']);
fea = d.fea;
[gnd,~] = normal_label(d.gnd); % 让label从1开始

% 生成k折验证
[i_learn, i_holdout] = get_kholdout(gnd, k_out);
for i_out =  1:k_out
    fea_learn = fea(i_learn{i_out},:);
    gnd_learn = gnd(i_learn{i_out});
    
    [i_train, i_valid] = get_kholdout(gnd_learn, k_in);
    for i_in =  1:k_in
        now_data{i_in,1} = [fea_learn(i_train{i_in},:),gnd_learn(i_train{i_in})];
        now_data{i_in,2} = [fea_learn(i_valid{i_in},:),gnd_learn(i_valid{i_in})];
    end%for_i_in
    data{i_out,1} = strcat('CV_',num2str(i_out));
    data{i_out,2} = now_data;
    data{i_out,3} = [fea(i_holdout{i_out},:),gnd(i_holdout{i_out})];
    clear now_data;clear fea_learn;clear gnd_learn;
    
end%for_i_out

% 存储数据
T5x5 = data;
save('T5x5.mat','T5x5');   

end % function


function [new_label, c] = normal_label(old_label)
% 把old_label的值保序变到自然数区间
    class_distribute = unique(old_label);
    c = length(class_distribute);%总类别数
    new_label = old_label;
    for i_c = 1:c
        new_label(find(old_label == class_distribute(i_c))) = i_c;
    end%for_i_c

end % function



function [learn_cell, holdout_cell] = get_kholdout(v, k)
% 根据类别标记向量v与验证折数k分出学习集与预测集

    slice_vec = crossvalind('Kfold', v, k);
    for j = 1:k
        holdout_vec = (slice_vec == j);
        learn_vec = ~holdout_vec;
        learn_cell{j} = learn_vec;
        holdout_cell{j} = holdout_vec;
        clear learn_vec; clear holdout_vec;
    end% for_j
     
end % function



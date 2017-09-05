function [res] = get_binary_evaluate(label_pre, label_test)

% 根据预测类别向量与真实类别向量评估模型的表现，两个输入均为列向量
% 只适合二分类问题， label从1开始

% 统计一轮的结果
[label_pre,~] = normal_label(label_pre);
[label_test,c] = normal_label(label_test);    
cmp_label = (label_pre ~= label_test); % 把预测错误的样本设置为1，正确的为0

res_temp = [];
for i_c = 1:c
    if isempty(cmp_label(find(label_test == i_c)))
        cmp_now = 0;
    else
        cmp_now = cmp_label(find(label_test == i_c));
    end%if
    False_now = sum(cmp_now); % 当前类错分的样本个数
    True_now = length(cmp_now) - False_now; % 当前类正确的样本个数
    res_temp = [res_temp;[True_now, False_now]];
    clear True_now; clear False_now;
end%for_i_c

TP = res_temp(2,1);
FN = res_temp(2,2);
TN = res_temp(1,1);
FP = res_temp(1,2);
TPR = TP/(TP+FN);
TNR = TN/(TN+FP);
if TP + FP == 0
    PPV = 0;
else
    PPV = TP/(TP+FP);
end%if_PPV

if PPV + TPR == 0
    F1 = 0;
else
    F1 = 2*PPV*TPR/(PPV+TPR);
end%if_F1

Acc = (TP+TN)/(TP+FN+TN+FP); % 总分类精确度
AA = mean([TPR,TNR]); % 算术平均正确率
GM = sqrt(TPR*TNR);%几何平均正确率
All = mean([Acc,AA]); % Acc与AA的值


res = [TPR,TNR,PPV,F1,Acc,AA,GM,All]*100;

end %function

function [new_label, c] = normal_label(old_label)
% 把old_label的值保序变到自然数区间
    class_distribute = unique(old_label);
    c = length(class_distribute);%总类别数
    new_label = old_label;
    for i_c = 1:c
        new_label(find(old_label == class_distribute(i_c))) = i_c;
    end%for_i_c

end % function



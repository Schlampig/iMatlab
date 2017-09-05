function [res] = get_multi_evaluate(label_test, label_pre)

% 根据预测类别向量与真实类别向量评估模型的表现，两个输入均为列向量
% 只适合二分类问题， label从1开始

% 统计一轮的结果
[label_test,c] = normal_label(label_test); 
[label_pre,~] = normal_label(label_pre);
cmp_label = (label_pre ~= label_test); % 把预测错误的样本设置为1，正确的为0

R = [];
for i_c = 1:c
    if isempty(cmp_label(find(label_test == i_c)))
        cmp_now = 0;
    else
        cmp_now = cmp_label(find(label_test == i_c));
    end%if
    False_now = sum(cmp_now); % 当前类错分的样本个数
    True_now = length(cmp_now) - False_now; % 当前类正确的样本个数
    R = [R;[True_now, False_now]];
    clear True_now; clear False_now;
end%for_i_c

tpr_vec = R(:,1)./(R(:,1)+R(:,2));
Acc = sum(R(:,1))/sum(R(:,1)+R(:,2)); % 总分类精确度
AA = mean(tpr_vec); % 算术平均TPR
GM = nthroot(prod(tpr_vec),length(tpr_vec)); % 几何平均TPR
All = mean([Acc,AA]); % Acc与AA的值

res = [-1,-1,-1,-1,Acc,AA,GM,All]*100;

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



function [e] = mat_get_e(train_binary_data,train_binary_label,I,I_new,w,b)

%迭代中用来获取权重向量e的函数
clear e;

for p_e = 1:size(train_binary_label)
    if p_e == 1
        e_temp = w'*train_binary_data(p_e,:)';
        E = e_temp;
    else
        e_temp = w'*train_binary_data(p_e,:)';
        E = [E;e_temp];
    end%end_if
end%end_p_e

e = E - I - b;
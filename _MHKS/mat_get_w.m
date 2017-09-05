function [w] = mat_get_w(train_binary_data,train_binary_label,InputPar,I,I_new,b)

%迭代中用来获取权重向量e的函数
clear w;

for p_w = 1:size(train_binary_label)
    if p_w == 1
        y = train_binary_label(p_w)*train_binary_data(p_w,:)';
        Y = y;
    else
        y = train_binary_label(p_w)*train_binary_data(p_w,:)';
        Y = [Y,y];
    end%end_if
end%end_p_w
Y = Y';

w = pinv(InputPar.C*I_new + Y'*Y)*Y'*(I+b);
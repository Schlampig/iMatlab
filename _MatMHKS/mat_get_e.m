function [e] = mat_get_e(train_binary_data,train_binary_label,M_row,M_col,I,u,v,b)

%迭代中用来获取权重向量e的函数
clear e;

for p_e = 1:size(train_binary_label)
    if p_e == 1
        A = reshape(train_binary_data(p_e,:),M_row,M_col);
        B=[A zeros(size(A,1),1);zeros(1,size(A,2)) 1];
        e_temp = train_binary_label(p_e)*u'*B*v;
        E = e_temp;
        clear A;clear B;
    else
        A = reshape(train_binary_data(p_e,:),M_row,M_col);
        B=[A zeros(size(A,1),1);zeros(1,size(A,2)) 1];
        e_temp = train_binary_label(p_e)*u'*B*v;
        E = [E;e_temp];
        clear A;clear B;
    end%end_if
end%end_p_e

e = E - I - b;
function [v] = mat_get_v(train_binary_data,train_binary_label,InputPar,M_row,M_col,S2,I,u,b)

%迭代中用来获取权重向量v的函数
clear v;

for p_v = 1:size(train_binary_label)
    if p_v == 1
        A = reshape(train_binary_data(p_v,:),M_row,M_col);
        B=[A zeros(size(A,1),1);zeros(1,size(A,2)) 1];
        y = train_binary_label(p_v)*(u'*B)';
        Y = y;
        clear A;clear B;
    else
        A = reshape(train_binary_data(p_v,:),M_row,M_col);
        B=[A zeros(size(A,1),1);zeros(1,size(A,2)) 1];
        y = train_binary_label(p_v)*(u'*B)';
        Y = [Y,y];
        clear A;clear B;
    end%end_if
end%end_p_v 
Y = Y';

v = pinv(InputPar.C*S2 + Y'*Y)*Y'*(I+b);


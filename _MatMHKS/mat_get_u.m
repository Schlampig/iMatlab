function [u] = mat_get_u(train_binary_data,train_binary_label,InputPar,M_row,M_col,S1,I,v,b)

%迭代中用来获取权重向量u的函数
clear u;

for p_u = 1:size(train_binary_label)
    if p_u == 1
        A = reshape(train_binary_data(p_u,:),M_row,M_col);
        B=[A zeros(size(A,1),1);zeros(1,size(A,2)) 1];
        z = train_binary_label(p_u)*B*v;
        Z = z;
        clear A;clear B;
    else
        A = reshape(train_binary_data(p_u,:),M_row,M_col);
        B=[A zeros(size(A,1),1);zeros(1,size(A,2)) 1];
        z = train_binary_label(p_u)*B*v;
        Z = [Z,z];
        clear A;clear B;
    end%end_if
end%end_p_u
Z = Z';

u = pinv(InputPar.C*S1 + Z'*Z)*Z'*(I+b);
u = [u(1:M_row);1];%让u的最后一位总是为1

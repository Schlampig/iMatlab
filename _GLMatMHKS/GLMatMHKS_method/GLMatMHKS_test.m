function [Group] = GLMatMHKS_test(GLMatStruct,test_data_final,label_one,label_two,M_row,M_col)

%用于测试GLMatMHKS的代码
%GLMatStruct：含有用于当前测试的训练数据的结构体
%test_data_final：测试数据集


for p_test = 1:size(test_data_final,1)
    A = reshape(test_data_final(p_test,:),M_row,M_col);
    B=[A zeros(size(A,1),1);zeros(1,size(A,2)) 1];
    class_tag = GLMatStruct.u'*B*GLMatStruct.v;
    if class_tag >= 0
        Group(p_test) = label_one;
    else
        Group(p_test) = label_two;
    end%end_if
end%end_for_p_test

Group = Group';
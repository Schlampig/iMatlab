function [Group] = CIMatMHKS_test(MatStruct,TestStruct,label_one,label_two,test_num)

%用于测试CIMatMHKS的代码
%MatStruct：含有用于当前测试的训练数据的结构体
%test_num:测试样本数


for p_test = 1:test_num
    A = TestStruct(p_test).mat;
    B=[A zeros(size(A,1),1);zeros(1,size(A,2)) 1];
    class_tag = MatStruct.u'*B*MatStruct.v;
    if class_tag >= 0
        Group(p_test) = label_one;
    else
        Group(p_test) = label_two;
    end%end_if
end%end_for_p_test

Group = Group';
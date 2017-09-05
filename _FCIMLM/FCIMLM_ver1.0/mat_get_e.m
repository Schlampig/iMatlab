function [e] = mat_get_e(TrainStruct,train_binary_label,I,u,v,b)

%迭代中用来获取权重向量e的函数
clear e;

for p_e = 1:size(train_binary_label)
    if p_e == 1
        A = TrainStruct(p_e).mat;
        B=[A zeros(size(A,1),1);zeros(1,size(A,2)) 1];
        e_temp = train_binary_label(p_e)*u'*B*v;
        E = e_temp;
        clear A;clear B;
    else
        A = TrainStruct(p_e).mat;
        B=[A zeros(size(A,1),1);zeros(1,size(A,2)) 1];
        e_temp = train_binary_label(p_e)*u'*B*v;
        E = [E;e_temp];
        clear A;clear B;
    end%end_if
end%end_p_e

e = E - I - b;
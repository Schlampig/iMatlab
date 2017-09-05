function [Group] = UMultiV_MHKS_test(UMultiVStruct,test_data_final,label_one,label_two,Row,Col)

%用于测试UMultiV-MHKS的代码
%UMultiVStruct：含有用于当前测试的训练数据的结构体
%test_data_final：测试数据集


M = size(Row,1);

for k_test_N = 1:size(test_data_final,1)
    tempt_test = 0;
    for k_test_M = 1:M  
        Z = reshape(test_data_final(k_test_N,:),Row(k_test_M),Col(k_test_M));
        tempt_test = tempt_test + UMultiVStruct(k_test_M).u'*Z*UMultiVStruct(k_test_M).v(1:Col(k_test_M)) + UMultiVStruct(k_test_M).v(Col(k_test_M)+1);
    end%end_for_k_test_M
    G = tempt_test/M;
    if G >= 0
        Group(k_test_N) = label_one;
    else
        Group(k_test_N) = label_two;
    end%end_if
end%end_for_k_test_N

Group = Group';
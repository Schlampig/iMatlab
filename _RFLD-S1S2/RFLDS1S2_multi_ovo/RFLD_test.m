function [label_pre] = RFLD_test(test_all, clf)

% 测试RFLD的函数
% test_all：一行一个样本，无label

% 传递参数
w = clf.w;
w0 = clf.w0;
% 测试
label_pre = [];
for i_test = 1:size(test_all,1)   
    x = test_all(i_test,1:end-1)';
    y = w'*x + w0;
    if y >= 0;%是正类
        label_temp = 1;
    else%是负类
        label_temp = 0;
    end%if
    label_pre = [label_pre;label_temp];
    clear label_temp;  
end%for_i_test

end % function
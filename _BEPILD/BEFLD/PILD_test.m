function [vec_res] = PILD_test(test_all,model)

% 原始版本PILD_test

% 传递参数
w = model.w;
w0 = model.w0;

% 预处理
[row_test,col_test] = size(test_all);

r_classone = length(find(test_all(:,end)==0));%统计测试数据label属于负类的个数（label==0）
r_classtwo = row_test - r_classone;%统计测试数据label属于正类的个数（label==1）
vec_acc_1 = zeros(r_classone,1);%行是测试样本数，列是第1类(负类Negative)
vec_acc_2 = zeros(r_classtwo,1);%行是测试样本数，列是第2类（正类Positive）
count_1 = 1;%初始化计数
count_2 = 1;

for i_test = 1:row_test   
    x = test_all(i_test,1:col_test-1)';
    y = w'*x + w0;
    %d = test_all(i_test,col_test);
    
    if y >= 0;%是正类
        label_temp = 1;
    else%是负类
        label_temp = 0;
    end%if
    
    if label_temp == test_all(i_test,end);
        answer = 1;
    else
        answer = 0;
    end%if
    
    if test_all(i_test,end) == 0;%负类
        vec_acc_1(count_1) = answer;
        count_1 = count_1 + 1;
    else%正类
        vec_acc_2(count_2) = answer;
        count_2 = count_2 + 1;
    end%if
        
end%for_i_test

TP = length(find(vec_acc_2(:)==1));%少数类（Positive）里面分对的个数
TN = length(find(vec_acc_1(:)==1));%多数类（Negative）里面分对的个数
FN = r_classtwo - TP;%少数类（Positive）里面分错的个数
FP = r_classone - TN;%多数类（Negative）里面分错的个数

TP_rate = TP/(TP+FN);
FP_rate = FP/(FP+TN);
TN_rate = TN/(FP+TN);
FN_rate = FN/(TP+FN);
Acc = (TP+TN)/(TP+TN+FP+FN)*100;%总分类精确度
Acc2 = (TP_rate+TN_rate)*50;%算术平均
GM = sqrt(TP_rate*TN_rate)*100;%几何平均
AUC = (1+TP_rate-FP_rate)*50;%AUC（无效）

vec_res = [TP,FP,TN,FN,Acc,Acc2,GM,AUC];
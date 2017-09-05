function [final_res] = kNN_multi(train_all,test_all,k)


%使用近邻算法测量多类大数据集。
%超出范围的设置没有报错机制，看着办。
%k:近邻值

%预备步骤
sum_class = max(train_all(:,end));%得到总类数
final_res = zeros(sum_class+3,1);%列向量，每一类正确率+Acc+AUC+testtime

%测试步骤：


tic;
tempor_vec = kNN_test(train_all,test_all,k);
t2 = toc;

tempor_res = tempor_vec - test_all(:,end);%正确的类标号所在列为0，不正确则非零
tempor_res(find(tempor_res~=0)) = 1;%另分类错误的列为1 
final_res(sum_class + 1,1) = (size(tempor_res) - sum(tempor_res))/size(tempor_res)*100;%分类总精确度Acc=正确分类样本数/测试样本总数*100%

for i_statis = 1:sum_class
    tempor_class_label = find(test_all(:,end)==i_statis);%每一类测试样本数
    final_res(i_statis)  = (size(tempor_class_label,1) - sum(tempor_res(tempor_class_label)))/size(tempor_class_label,1) * 100;%当前类内分类精度
end%for_i_statis

final_res(sum_class + 2,1) = mean(final_res(1:sum_class,1));%平均分类精确度AUC=每一类分类精确度/类总数
final_res(sum_class + 3,1) = t2;%测试总时间


end%function
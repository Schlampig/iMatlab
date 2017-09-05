function [vec_res] = BERL_test(test_all,model)


% 加入启发式规则的随机BEPILD_test

% 传递参数
w = model.w;
bpos = model.bpos;
bneg =  model.bneg;
candi_dis_pos = model.candi_dis_pos;
candi_dis_neg = model.candi_dis_neg;

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
    ypos = w'*x + bpos;
    yneg = w'*x + bneg;
    
    if yneg <= 0%比左侧分类面更左侧
        label_temp = 0;%负类
    elseif ypos >= 0%比右侧分类面更右侧
        label_temp = 1;%正类      
    else%z在中间区域
        test_dis_pos = abs(ypos);
        test_dis_neg = abs(yneg);
        p_pos = length(find(candi_dis_pos > test_dis_pos))/length(candi_dis_pos);%训练正类中比测试样本更远离训练正类质心所在超平面的点的个数/两质心分类面间总训练正类样本数
        p_neg = length(find(candi_dis_neg > test_dis_neg))/length(candi_dis_neg);%训练负类中比测试样本更远离训练负类质心所在超平面的点的个数/两质心分类面间总训练负类样本数
        if p_pos >= p_neg
            label_temp = 1;
        else
            label_temp = 0;
        end
    end
   
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
function [label_pre] = RFLDS2_test(test_all, clf)

% 测试RFLDS2的函数
% test_all：一行一个样本，无label

% 传递参数
if clf.flag == 1 % 可分情形，不需要使用启发式算法
    label_pre = RFLD_test(test_all, clf);
elseif clf.flag == 0 %重叠情形，需要使用启发式算法
    w = clf.w;
    w0 = clf.w0;
    bpos = clf.bpos;
    bneg =  clf.bneg;
    candi_dis_pos = clf.candi_dis_pos;
    candi_dis_neg = clf.candi_dis_neg;
    % 测试
    label_pre = [];
    for i_test = 1:size(test_all,1)   
        x = test_all(i_test,1:end-1)';
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
            if p_pos > p_neg
                label_temp = 1;
            elseif p_pos < p_neg
                label_temp = 0;
            else%如果概率一样，则再使用传统的伪逆分类面比较
                y = w'*x + w0;
                if y >= 0;%是正类
                    label_temp = 1;
                else%是负类
                    label_temp = 0;
                end%if
            end%if
        end%if
        label_pre = [label_pre;label_temp];
        clear label_temp;
    end%for_i_test
end%if

end % function
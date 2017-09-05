function [pre_pos,pre_neg] = BEPILD_testone(test_data,model)


% 加入启发式规则的BEPILD_test，只测试一个样本，只返回预测类标记

% 传递参数
w = model.w;
w0 = model.w0;
bpos = model.bpos;
bneg =  model.bneg;
candi_dis_pos = model.candi_dis_pos;
candi_dis_neg = model.candi_dis_neg;
test_num = size(test_data,1);

% 预测
pre_label = [];
for i = 1:test_num    
    x = test_data(i,:)';%列向量x
    ypos = w'*x + bpos;
    yneg = w'*x + bneg;

    if yneg <= 0%比左侧分类面更左侧
        label = 0;%负类   
    elseif ypos >= 0%比右侧分类面更右侧
        label = 1;%正类      
    else%z在中间区域
        test_dis_pos = abs(ypos);
        test_dis_neg = abs(yneg);
        p_pos = length(find(candi_dis_pos > test_dis_pos))/length(candi_dis_pos);%训练正类中比测试样本更远离训练正类质心所在超平面的点的个数/两质心分类面间总训练正类样本数
        p_neg = length(find(candi_dis_neg > test_dis_neg))/length(candi_dis_neg);%训练负类中比测试样本更远离训练负类质心所在超平面的点的个数/两质心分类面间总训练负类样本数
        if p_pos > p_neg
            label = 1;
        elseif p_pos < p_neg
            label = 0;
        else%如果概率一样，则再使用传统的伪逆分类面比较
            y = w'*x + w0;
            if y >= 0;%是正类
                label = 1;
            else%是负类
                label = 0;
            end%if
        end%if
    end%if    
    pre_label = [pre_label;label];    
end%for

pre_pos = test_data(find(pre_label==1),:);
pre_neg = test_data(find(pre_label==0),:);


end %function
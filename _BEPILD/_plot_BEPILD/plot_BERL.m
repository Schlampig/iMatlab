function plot_BERL

% xxx_r:当前样本点的半径（分布范围）
% xxx_num：当前样本点的数目

% 初始化
total_range = 1;

pos_r = 0.6*total_range;
neg_r = 0.2*total_range;
pos_num = 20;
neg_num = 300;
test_num = 100;

pos_center = [0.3*total_range,0.3*total_range];
neg_center = [0.7*total_range,0.7*total_range];

% 生成数据集
axis_pos = [total_range.*rand(pos_num,1),total_range.*rand(pos_num,1)];
axis_neg = [total_range.*rand(neg_num,1),total_range.*rand(neg_num,1)];
axis_test = [total_range.*rand(test_num,1),total_range.*rand(test_num,1)];
[train_pos, label_pos] = filter(axis_pos,pos_num,pos_center,pos_r);
[train_neg, label_neg] = filter(axis_neg,neg_num,neg_center,neg_r);

train_all = [[train_pos,ones(label_pos,1)];[train_neg,zeros(label_neg,1)]];
test_data = filter_test(axis_test,test_num,pos_center,pos_r,neg_center,neg_r);

% 代入模型
% 训练
model = BERL_trainplot(train_all);
% 预测
[pre_pos,pre_neg] = BERL_testone(test_data,model);

% 绘图
figure;  

slope = -model.w(1)/model.w(2);
threshold_pos = - model.bpos/model.w(2);
threshold_neg = - model.bneg/model.w(2);
% 两条分类线（随机的没有第三条）
x_range = 0:total_range;
y_lpos = x_range*slope + threshold_pos;
y_lneg = x_range*slope + threshold_neg;

% 两类的圆域
alpha = 0:pi/20:2*pi;
x_posO = pos_r*cos(alpha) + pos_center(1);
y_posO = pos_r*sin(alpha) + pos_center(2);
x_negO = neg_r*cos(alpha) + neg_center(1);
y_negO = neg_r*sin(alpha) + neg_center(2);

plot(x_range,y_lpos,'b-.',...
    x_range,y_lneg,'r--',...
    x_posO,y_posO,'b-.',...
    x_negO,y_negO,'r--',...
    train_pos(:,1),train_pos(:,2),'b+',...
    train_neg(:,1),train_neg(:,2),'ro',...
    pre_neg(:,1),pre_neg(:,2),'gx',...
    pre_pos(:,1),pre_pos(:,2),'ks',...
    'LineWidth',2.5,'MarkerSize',10);

title('BERL','fontsize',20,'fontname','Times New Roman','fontweight','bold');
xlabel('x','fontsize',20,'fontname','Times New Roman','fontweight','bold');
ylabel('y','fontsize',20,'fontname','Times New Roman','fontweight','bold');
legend('l_{pos}','l_{neg}','range for positive class','range for negative class','positive sample','negative sample','test sample (pre=pos)','test sample (pre=neg)','fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
axis([0,total_range,0,total_range]); 
grid on;

end%function


% 生成圆内的散点
function [axis,len_axis] = filter(axis,length,c,r)
    index = [];
    for i = 1:length
        if (axis(i,1)-c(1))^2 + (axis(i,2)- c(2))^2 > r^2 %不在规定的圆内
            index = [index;0];
        else
            index = [index;1];
        end%if
    end%for 
    axis = axis(find(index == 1),:);%只把满足条件的留下
    len_axis = size(axis,1);
end%function

% 生成测试样本点
function [axis,len_axis] = filter_test(axis,length,c1,r1,c2,r2)
    index = [];
    for i = 1:length
        if ((axis(i,1)-c1(1))^2 + (axis(i,2)- c1(2))^2 < r1^2) || ((axis(i,1)-c2(1))^2 + (axis(i,2)- c2(2))^2 < r2^2) % 在规定的两个圆内
            index = [index;1];
        else
            index = [index;0];
        end%if
    end%for 
    axis = axis(find(index == 1),:);%只把满足条件的留下
end%function



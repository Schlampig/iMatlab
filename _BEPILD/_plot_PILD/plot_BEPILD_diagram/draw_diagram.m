function draw_diagram

% Settings--------------------------------------------------------------%
r_pos = 25;%设置生成圆半径
r_neg = 45;
center_pos = 30;%设置生成圆圆心c（m,m）
center_neg = 55;
IR = 3;% IR>2;
num_pos = 150; 
num_neg = IR*num_pos;
x = [0:110]';%图片尺寸
x_pos = x;
x_neg = x;
% Generate random points------------------------------------------------%
data_pos = 100*rand([num_pos,2]);
data_neg = 100*rand([num_neg,2]);

% Filter points---------------------------------------------------------%
points_pos = cal_circle(data_pos(:,1),data_pos(:,2),r_pos,center_pos);
points_neg = cal_circle(data_neg(:,1),data_neg(:,2),r_neg,center_neg);

% Calculate w and b for each plan---------------------------------------%
[w,~] = PILD(points_pos,points_neg); % w in Dx1
% Plan-A
lpos_pa = - (w(1)'*x_pos - w'*mean(points_pos)')./w(2:end); % mean(points_pos) in 1xD
lneg_pa = - (w(1)'*x_neg - w'*mean(points_neg)')./w(2:end);
% Plan-B
w_wrong = [-1,5];
lpos_pb = - (w_wrong(1)*x_pos - w_wrong*mean(points_pos)')./w_wrong(2:end); 
lneg_pb = - (w_wrong(1)*x_neg - w_wrong*mean(points_neg)')./w_wrong(2:end);
% Plan-C
lpos_pc = - (w(1)'*x_pos - w'*cal_distance(points_pos,points_neg,'far',0)')./w(2:end);
lneg_pc = - (w(1)'*x_neg - w'*cal_distance(points_pos,points_neg,'far',1)')./w(2:end);
% Plan-D
lpos_pd = - (w(1)'*x_pos - w'*cal_distance(points_pos,points_neg,'near',1)')./w(2:end);
lneg_pd = - (w(1)'*x_neg - w'*cal_distance(points_pos,points_neg,'near',0)')./w(2:end);
% Test point
test_point = 0.4*(mean(points_pos) + mean(points_neg));%离本类质心最远两点的中点

% Clean the w
clear w;clear w_wrong;

% Draw diagram----------------------------------------------------------%
% Plan-A
figure;
plot(points_pos(:,1),points_pos(:,2),'ro',...
    points_neg(:,1),points_neg(:,2),'b*',...
    x_pos,lpos_pa,'k-',...
    x_neg,lneg_pa,'k-.',...
    'LineWidth',2.5,'MarkerSize',10);
title('i) Plan-A','fontsize',24,'fontname','Times New Roman','fontweight','bold');
legend('Positive class','Negative class','L_{pos}','L_{neg}','fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
axis([min(x),max(x),min(x),max(x)]); 
grid on;

% Plan-B
figure;
plot(points_pos(:,1),points_pos(:,2),'ro',...
    points_neg(:,1),points_neg(:,2),'b*',...
    x_pos,lpos_pb,'k-',...
    x_neg,lneg_pb,'k-.',...
    'LineWidth',2.5,'MarkerSize',10);
title('ii) Plan-B','fontsize',24,'fontname','Times New Roman','fontweight','bold');
legend('Positive class','Negative class','L_{pos}','L_{neg}','fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
axis([min(x),max(x),min(x),max(x)]); 
grid on;

% Plan-C
figure;
plot(points_pos(:,1),points_pos(:,2),'ro',...
    points_neg(:,1),points_neg(:,2),'b*',...
    x_pos,lpos_pc,'k-',...
    x_neg,lneg_pc,'k-.',...
    'LineWidth',2.5,'MarkerSize',10);
title('iii) Plan-C','fontsize',24,'fontname','Times New Roman','fontweight','bold');
legend('Positive class','Negative class','L_{pos}','L_{neg}','fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
axis([min(x),max(x),min(x),max(x)]); 
grid on;

% Plan-D
figure;
plot(points_pos(:,1),points_pos(:,2),'ro',...
    points_neg(:,1),points_neg(:,2),'b*',...
    x_pos,lpos_pd,'k-',...
    x_neg,lneg_pd,'k-.',...
    'LineWidth',2.5,'MarkerSize',10);
title('iv) Plan-D','fontsize',24,'fontname','Times New Roman','fontweight','bold');
legend('Positive class','Negative class','L_{pos}','L_{neg}','fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
axis([min(x),max(x),min(x),max(x)]); 
grid on;

% Draw boundaries-------------------------------------------------------%
figure;
plot(points_pos(:,1),points_pos(:,2),'ro',...
    points_neg(:,1),points_neg(:,2),'b*',...
    test_point(1),test_point(2),'ks',...
    'LineWidth',2.5,'MarkerSize',10);
title('i) Original Problem','fontsize',24,'fontname','Times New Roman','fontweight','bold');
legend('Positive class','Negative class','Test sample','fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
axis([min(x),max(x),min(x),max(x)]); 
grid on;

figure;
plot(points_pos(:,1),points_pos(:,2),'ro',...
    test_point(1),test_point(2),'ks',...
    'LineWidth',2.5,'MarkerSize',10);
title('ii) One-class recognition problem A','fontsize',24,'fontname','Times New Roman','fontweight','bold');
legend('Positive class','Test sample','fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
axis([min(x),max(x),min(x),max(x)]); 
grid on;

figure;
plot(points_neg(:,1),points_neg(:,2),'b*',...
    test_point(1),test_point(2),'ks',...
    'LineWidth',2.5,'MarkerSize',10);
title('iii) One-class recognition problem B','fontsize',24,'fontname','Times New Roman','fontweight','bold');
legend('Negative class','Test sample','fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
axis([min(x),max(x),min(x),max(x)]); 
grid on;

% BEPILD steps-------------------------------------------------------%
% Step-0

% Step-1

% Step-2

% Step-3

% Step-4

% Step-5

% Step-6



end%function_draw_diagram




function [points] = cal_circle(x,y,r,c)
    n = size(x,1);
    vec_one = ones(n,1);
    r_diff = (x - c*vec_one).^2 + (y - c*vec_one).^2; % r^2 = x^2 + y^2
    index = find(r_diff <= r^2);
    x_new = x(index);
    y_new = y(index);
    points = [x_new,y_new];
end%function_cal_circle

function [w,b] = PILD(X_pos,X_neg)    
    %生成矩阵，标号和扰动项
    num_reg = 0.00001;
    lable_pos = 1;
    lable_neg = -1;
    X_all = [X_pos;X_neg];
    X_all = [ones(size(X_all,1),1),X_all]; % X_all in Nx(D+1)
    dp = [lable_pos*ones(size(X_pos,1),1);lable_neg*ones(size(X_neg,1),1)] ;
    I_reg = num_reg * eye(size(X_all,2)); %生成正则化扰动项I_reg in (D+1)x(D+1) 
   
    % 使用PILD计算最初的超平面
    w_all = inv(X_all'*X_all + I_reg)*X_all'*dp;%w_all in (D+1)x1
    w = w_all(2:end,1); % Dx1
    b = w_all(1,1);%w_all的第一个元素是b，之后是w    

end%function_PILD

function [point] = cal_distance(X_pos,X_neg,d,tag)
    m_pos = mean(X_pos);%求质心
    m_neg = mean(X_neg);
    [~,i_near_neg] = min(sum((X_neg - repmat(m_pos,size(X_neg,1),1)).^2,2));%离正类圆心最近的负类样本坐标
    [~,i_near_pos] = min(sum((X_pos - repmat(m_neg,size(X_pos,1),1)).^2,2));%离负类圆心最近的正类样本坐标
    [~,i_far_neg] = max(sum((X_neg - repmat(m_pos,size(X_neg,1),1)).^2,2));%离正类圆心最远的负类样本坐标
    [~,i_far_pos] = max(sum((X_pos - repmat(m_neg,size(X_pos,1),1)).^2,2));%离负类圆心最远的正类样本坐标
    if strcmp(d,'near')
        if tag == 1%最近负类
            point = X_neg(i_near_neg,:); % point in 1xD
        else%最近正类
            point = X_pos(i_near_pos,:);
        end%if_tag
    else
        if tag == 1%最远负类
            point = X_neg(i_far_neg,:);
        else%最远正类
            point = X_pos(i_far_pos,:);
        end%if_tag
    end%if_d
    
end%function_cal_distance



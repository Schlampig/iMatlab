function res_statistic_friedman

% 载入结果数据集，包含四个矩阵，两个是指标，两个是这些指标对应的std，每个矩阵列数是数据集个数，行数是方法个数
load('Res_LPP_new.mat'); 
name_alg = {'64','100','128','200','300','512'};
num_alg = 8;
n = size(AUC_mat,1);%总情形，行数
num_d = n/num_alg; % num_alg个算法的num_d种降维情况合起来是n种情况

for i = 1:num_d
    file_name = strcat('Res_rank_dim',name_alg{i},'.mat');
    % 提取当前的结果矩阵
    AUC_now = AUC_mat((num_alg*(i-1)+1):num_alg*i,:);
    Acc_now = Acc_mat((num_alg*(i-1)+1):num_alg*i,:);
    % 计算排名
    AUC_score = get_score(AUC_now');
    Acc_score = get_score(Acc_now');  
    
    save(file_name,'AUC_score','Acc_score');      
end%for_i

end%function


function [Y] = get_score(X)
    % X行数是数据集个数，列数是方法个数
    Y = [];
    Z = [];
    for i = 1:size(X,1)
        score = sort_friedman(X(i,:)); % 性能越好，score越小
        % Option 1
%         Y = [Y; [X(i,:);score]];%如果选择，则前一列是指标，后一列是排名
        % Option 2
        Y = [Y;score];%如果选择，只有一列排名
        Z = [Z;score];
        clear score;
    end%for_i
    
    % Option 1
%     m = mean(X); % 均值
%     m_score = sort_friedman(m); % 平均值的排名，均值越高排名值越大
%     Y = [Y; [m;m_score;mean(Z)]]; % Y最后三行分别是指标矩阵X的均值，针对这个均值的得分，以及对单个数据集得分汇总后的均值，score越大表示性能越好    
    % Option 2
    Y = [Y;sum(Z)];
    
    Y = Y';%最后三列是rank
end%function


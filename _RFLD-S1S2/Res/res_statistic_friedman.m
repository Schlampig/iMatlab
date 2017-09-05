function res_statistic_friedman

% 载入结果数据集，包含六个矩阵，三个是指标，三个是这些指标对应的std，每个矩阵行数是数据集个数，列数是方法个数
load('Res_BEFLD_related.mat'); 

AUC_score = get_score(AUC_mat);
Acc_score = get_score(Acc_mat);
GM_score = get_score(GM_mat);

AUC_std = get_std(AUC_std_mat);
Acc_std = get_std(Acc_std_mat);
GM_std = get_std(GM_std_mat);

save('Score_friedman_selected.mat','AUC_score','Acc_score','GM_score','AUC_std','Acc_std','GM_std');

end%function


function [Y] = get_score(X)
    % X行数是数据集个数，列数是方法个数
    Y = [];
    Z = [];
    for i = 1:size(X,1)
        score = sort_friedman(X(i,:)); % 性能越好，score越小
        Y = [Y; [X(i,:);score]];
        Z = [Z;score];
        clear score;
    end%for_i
    m = mean(X); % 均值
    m_score = sort_friedman(m); % 平均值的排名，均值越高排名值越大
    Y = [Y; [m;m_score;mean(Z)]]; % Y最后三行分别是指标矩阵X的均值，针对这个均值的得分，以及对单个数据集得分汇总后的均值，score越大表示性能越好
end%function


function [Y] = get_std(X)
    Y = -1*ones(2*size(X,1),size(X,2));
    Y(1:2:end,:) = X;
end%function


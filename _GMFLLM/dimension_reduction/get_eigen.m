function [TMat] = get_eigen(A,B,Rdim)


% 获取降维后信息的函数，包括特征值分解步骤，即 Aw = lamda*Bw
% TMat:Transform Matrix，包含Rdim个特征向量的变换矩阵

%判断B是否为单位矩阵
    r = size(B,1);
    C = eye(r);

%特征值分解
    if isequal(B,C) == 0 %B不是单位阵，说明是含有逆矩阵的算法
        [eigvector, lamda] = eig(A,B);        
    elseif isequal(B,C) == 1 %B是单位阵，说明是MMC相关算法
        [eigvector, lamda] = eig(A);
    end%if

%特征值排序
    lamda_tempor = diag(lamda);%将特征值矩阵变为向量
    [~, index] = sort(-lamda_tempor);%把最大特征值排在前面
    eigvector = eigvector(:,index);%(含下一句)根据index将eigvector按特征值那边从大到小排序，留下的列排前面
    TMat = eigvector(:,1:Rdim);%得到最终的变换矩阵，是d*Rdim维的
    
end%function
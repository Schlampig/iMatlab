function [C] = constructC(W)

%输入一个关联矩阵W（无监督），返回一个普查矩阵C

n = size(W,1);%求关联矩阵阶数，即样本总数
C = zeros(n);%初始化普查矩阵

for i_sample = 1:n
    vec_now = W(i_sample,:);
    for i = 1:n-1
        for j = i+1:n
            if vec_now(i)*vec_now(j) == 0
                continue;
            else%第i和第j个样本都属于第i_sample个样本的近邻
                C(i,j) = C(i,j) + 1;%那么i和j样本之间的关联性增强1
                C(j,i) = C(j,i) + 1;
        end%for_j
    end%for_i
end%for_i_sample


end%function


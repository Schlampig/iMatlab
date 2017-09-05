function [y] = friedman_sort(x)

% 按照Friedman测试中的排序方式对输入的向量x进行排序给分
% 规则：同排名rank值相同，为这些排名占用的原始排位值的均值，例如3-5位相同，那么rank都为mean([3,4,5])=4，性能越高排名值越小。
% x：行向量，乱序
% y：行向量，对应x每个元素的rank值

[x_sort,I_tempor] = sort(x);
[~,I] = sort(I_tempor);
x_sort = [x_sort,max(x_sort)+1]; %最后一位为预留位，不参与计算
i=1;
j=1;
x_rank = [];
while (i<length(x_sort))
    if x_sort(i) == x_sort(i+1)
        i = i + 1;
    else
        x_rank = [x_rank,((i+j)/2)*ones(1,i-j+1)];
        i = i + 1;
        j = i;
    end%if
end%while

y = x_rank(I);

end%function
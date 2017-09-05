function [aspect] = randwithoutre(X)

%目标：输入同一类所有样本，大约均分生成10份（10个cell），存在一个cell里返回
%X：每行一个样本，无类标号，列数是维度
%输出一个命名为aspect的cell,里面包含10个子cell，每个cell里每一行是一个训练样本

sample_num = size(X,1);%初始化
select_index = randperm(sample_num);%重排序列
r = 1;

while sample_num > 9
    aspect{1,1}(r,:) = X(select_index(1),:);
    aspect{1,2}(r,:) = X(select_index(2),:);
    aspect{1,3}(r,:) = X(select_index(3),:);
    aspect{1,4}(r,:) = X(select_index(4),:);
    aspect{1,5}(r,:) = X(select_index(5),:);
    aspect{1,6}(r,:) = X(select_index(6),:);
    aspect{1,7}(r,:) = X(select_index(7),:);
    aspect{1,8}(r,:) = X(select_index(8),:);
    aspect{1,9}(r,:) = X(select_index(9),:);
    aspect{1,10}(r,:) = X(select_index(10),:);
    select_index = select_index(11:end);%除掉选出的index
    if isempty(select_index) == 1
        sample_num = 0;
    else
        sample_num = length(select_index);
    end
    r = r + 1;
end

if sample_num >= 1 %剩下的样本
    for i = 1: sample_num
        aspect{1,i}(r,:) = X(select_index(i),:);
    end
end
    

end


















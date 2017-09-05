function [group] = kNN_test(train_all,test_all,k)

%近邻测试算法，返回group是测试类标号集合

group = [];
train_label = train_all(:,end);

for i_test = 1:size(test_all,1)
    %计算当前测试样本与所有训练样本的欧氏距离
    temp = repmat(test_all(i_test,1:end-1),size(train_all,1),1) - train_all(:,1:end-1);
    vec_temp = sqrt(sum(temp.^2,2));
    
    
    %统计出类标号    
    [~,index1] = sort(vec_temp);
    [~,index2] = sort(index1);%给距离排序
    vec_candidate = (train_label(find(index2<=k)))';%候选类向量，或一个数；转置为行向量是因为hist处理列向量时label和rank行列表示会变动
    if k ~=1%用于k近邻统计每一类近邻个数
        [j_rank,j_label] = hist(vec_candidate, unique(vec_candidate));%统计出现最多的值
        y = [j_label',j_rank']; 
        z = sortrows(y,-2);%按照出现次数多少来排序，次数少的沉底，降序加负号,把投票数最多的判定为当前分块所属于的类
    else
        z(1,1) = vec_candidate;%最近邻不必求离散分布并投票
    end%if
    
    test_label = z(1,1);   
    group = [group;test_label];
    
    clear temp;clear vec_temp;
    clear index1;clear index2;clear j_label;clear j_rank;
    clear vec_candidate;clear test_label;clear z;
end%for_i_test

end%function
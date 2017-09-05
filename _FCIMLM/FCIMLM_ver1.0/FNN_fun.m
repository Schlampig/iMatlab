function [attr_select] = FNN_fun(train_data,dc,attr_num)

%通过快速聚簇训练
%train_data，每行一个样本
%dc：距离
%attr_num：保留的属性数，只能是整数
%attr_select：一个矩阵，行数是维数（属性数），列数是选取的代表属性数

train_data = train_data';
[num_s,num_d] = size(train_data);%求样本总数num_s和样本维度num_d
attr_select = zeros(num_d, attr_num);%初始化

for i_d = 1:num_d
    mat_dim = abs(repmat(train_data(:,i_d),1,num_s) - repmat(train_data(:,i_d)',num_s,1));%求第i_d个属性的差值 %注意：这里是否取绝对值！
    mat_save = mat_dim;%备份一个矩阵
    %attr_r = (max(max(mat_dim)) - min(min(mat_dim)))*dc;%属性半径
    attr_r = mean(mean(mat_dim));%备选，平均距离当半径
    mat_dim(find(mat_dim>=attr_r)) = 0;%小于每个样本圆周的点取为1，大于的即不属于近邻点取为0
    mat_dim(find(mat_dim~=0)) = 1;
    vec_density = sum(mat_dim,2);%vec_density是每个样本第i_k个属性对应的密度列向量
    [~,index_1] = sort(vec_density);
    [~,index_2] = sort(index_1);%密度排序
    
    
    mat_density = repmat(vec_density,1,num_s) - repmat(vec_density',num_s,1);%构造密度差值矩阵
    mat_density(find(mat_density>=0)) = 0;%其他样本的密度不如当前样本的，置为0
    mat_density(find(mat_density~=0)) = 1;
    vec_distance = min(mat_density .* mat_save,[],2);%选出密度比自己大的点中距离最小的那个组成一个距离向量
    [~,index_3] = sort(vec_distance);
    [~,index_4] = sort(index_3);%距离排序
    
    vec_dd = abs(abs(index_2+index_4) - abs(index_2-index_4));%综合向量，那些密度大而且和邻近点距离远的点是代表点(即总值越大越好)%建议改成排名相减（或归一化）
    [~,index_5] = sort(vec_dd,'descend');%值越大排名越靠前
    [~,index_6] = sort(index_5);
    
    attr_select(i_d,:) = train_data(find(index_6<=attr_num),i_d);%选出当前维度的代表特征attr_num个
    
    clear mat_dim;clear mat_save;clear attr_r;clear mat_dim;
    clear vec_density;clear mat_density;clear vec_distance;
    clear vec_dd;clear index_1;clear index_2;clear index_3;clear index_4;clear index_5;clear index_6;
end%for_i_d

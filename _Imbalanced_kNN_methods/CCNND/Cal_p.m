function [p_res] = Cal_p(train,k)

%计算一个数据集样本两两距离，返回这样的概率p：
%p = 比第一个样本距离大的样本个数/除第一个样本外的其他样本总数

    X = train';%当前样本，每列一个样本
    n = size(X,2);%样本个数
    A=diag(X'*X);
    B=A';
    C =A*ones(1,n) + ones(n,1)*B - 2.*(X'*X);
    C = sqrt(C);
    mat_res = max(max(C))*eye(size(X,2)) + C;%把自己与自己相减的距离设置为最大，不参与计算。
    
    I_temp = zeros(n,k);%存放每个样本（包括测试样本）的前k个近邻的差值的矩阵，差值由小到大排列，第一行是测试样本的前k个差值
    for i_d = 1:n
        [~,index1] =  sort(mat_res(i_d,:));
        [~,index2] = sort(index1);
        vec_temp = mat_res(i_d,find(index2<(k+1)));
        I_temp(i_d,:) = sort(vec_temp);
        clear vec_temp;
    end%for_i_d
    
    I_temp2 = repmat(I_temp(1,:),n-1,1) - I_temp(2:n,:);
    I_temp2(find(I_temp2>=0)) = 0;
    I_temp2(find(I_temp2<0)) = -1;
    I_temp3 = sum(I_temp2,2);
    S = length(I_temp3(find(I_temp3==-1*size(I_temp3,2))));%计算出满足条件的训练样本点
    
    S_all = n-1;%同一类训练样本总数
    p_res = S/S_all;
    
end
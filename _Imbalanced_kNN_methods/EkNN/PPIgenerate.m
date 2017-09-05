function [train_all_new] = PPIgenerate(z,delta,train_all)

%在训练集中寻找PPI样本进行特殊标记

    %train_pos = train_all(find(train_all(:,end)==1),:);%生成只有正类的样本集
    index_pos = find(train_all(:,end)==1);%生成存放所有正类位置index的列向量
    index_neg = find(train_all(:,end)==0);
        
    mat_all = Cal_mat(train_all(:,1:end-1)');
    mat_pos = mat_all(index_pos,index_pos);%提取所有正类对所有正类的距离和
    mat_related = mat_all(index_pos,index_neg);%提取所有正类对所有负类的距离和
    
    vec_candi = min(mat_pos,[],2);%找出离每个正类样本最近的正类样本，得到它们之间的距离差组成列向量
   
    mat_related = repmat(vec_candi,1,length(index_neg)) - mat_related;
    mat_related(find(mat_related>=0)) = 1;%满足条件的点
    mat_related(find(mat_related<0)) = 0;%距离比第一个正类点远的负类点
    
    vec_k = sum(mat_related,2);%每个正类的k值，即每个正类球体内存在的负类的数目
    vec_f = (vec_k - ones(length(vec_k),1)) ./ (vec_k + ones(length(vec_k),1));%列向量
    vec_p = zeros(length(vec_k),1);
    
    for i = 1:length(vec_k)
       vec_p(i) = Cal_threshold(z,vec_k(i),vec_f(i));
    end
    index_final = index_pos(find(vec_p<=delta),1);%最终属于PPI的样本的index
    r_final = vec_candi(find(vec_p<=delta),1);%最终属于PPI的样本的半径取值
    train_radius = zeros(size(train_all,1),1);
    train_radius(index_final,1) = r_final;
    train_all_new = [train_all,train_radius];%新生成的训练集在最后多加一列
    
end


function [mat_res] = Cal_mat(X)
    n = size(X,2);%样本个数
    A=diag(X'*X);
    B=A';
    C =A*ones(1,n) + ones(n,1)*B - 2.*(X'*X);
    C = sqrt(C);
    mat_res = max(max(C))*eye(size(X,2)) + C;%把自己与自己相减的距离设置为最大，不参与计算。
end
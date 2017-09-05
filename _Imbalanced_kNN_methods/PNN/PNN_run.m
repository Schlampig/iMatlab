function [p] = PNN_run(train_all,query,k,delta,z)



mat_query = repmat(query,size(train_all,1),1);
vec_diff = sqrt(sum((mat_query - train_all(:,1:end-1)).*(mat_query - train_all(:,1:end-1)),2));%query和每个训练样本的欧氏距离范数，列向量
vec_diff_label = [vec_diff,train_all(:,end)];%和类标号合并
vec_diff_label = sortrows(vec_diff_label,1);%按照距离由小到大排序

p1 = 0;
n1 = 0;
i = 1;

while (i<=size(vec_diff_label,1) && p1< floor(k/2))
    if vec_diff_label(i,2) == 1
        p1 = p1 + 1;
    else
        n1 = n1 + 1;
    end
    i = i + 1;
end
r = p1 + n1;
fneg_local = n1/r;

e = Cal_threshold(z,fneg_local,r); 

if r>k && e<=delta
    p = floor(k/2)/k;
else
    p = p1/r;
end

end
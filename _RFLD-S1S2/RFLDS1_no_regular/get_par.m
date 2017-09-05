function [par] = get_par(data,size,w,mean_vec,tag)

% 根据样本和投影均值返回特定参数
% data:样本矩阵，一行一个样本 NxD
% size:样本矩阵的行数 N
% mean_vec:样本矩阵对应的投影均值 1x1
% w:权重向量，1xD
% tag:若为0，取均方差规模；若为1，取均值

if tag == 0
    par = sum(abs(data*w - mean_vec))/sqrt(size-1);
elseif tag == 1
    par = sum(abs(data*w - mean_vec))/size;
else
    par = 0; % 即默认没有偏差
end%if

end%function
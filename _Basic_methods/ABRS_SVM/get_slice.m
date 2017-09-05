function [r_slice_mat, c_slice_mat] = get_slice(ts, tf, num_r, num_c, ratio_r, ratio_c)

% 已知需要分片的(负类)数据集矩阵的行与列，生成分片组合的函数
% ts, tf：基分类器内外层循环次数，ts*tf是基分类总数
% num_r, num_c：数据集矩阵的行数与列数
% ratio_r, ratio_c：行（样本）与列（特征）的采样比例,区间()
% r_slice_mat, c_slice_mat：一行存一个行/列新采样下标

sub_r = num_r*ratio_r;
sub_c = num_c*ratio_c;

r_slice_mat = [];
c_slice_mat = [];
for i = 1:ts
    for j = 1:tf
        now_r = randperm(num_r);
        r_slice_mat = [r_slice_mat;now_r(1:sub_r)];
        
        now_c = randperm(num_c);
        c_slice_mat = [c_slice_mat;now_c(1:sub_c)];
        
        clear now_r; clear now_c;
    end%for_j
end%for_i


end % function
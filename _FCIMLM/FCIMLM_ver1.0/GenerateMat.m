function [MatrixStruct] = GenerateMat(AttrStruct,vec_data)

%使用插值法矩阵化生成新的矩阵型训练样本
sample_num = size(vec_data,1);%求当前总的训练样本数
[attr_r,attr_c] = size(AttrStruct);

for i_mat = 1:sample_num
    tempt_mat = [vec_data(i_mat,:);abs(repmat(vec_data(i_mat,:),attr_r,1) - AttrStruct)];
    MatrixStruct(i_mat).mat = tempt_mat;
    clear tempt_mat;
end%end_for_i_mat
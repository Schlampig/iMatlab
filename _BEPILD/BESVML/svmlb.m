function [b] = svmlb(X, mat_sv, vec_alpha)

% 假设X在分类面上，反向得到截距b的函数
% X：无label的矩阵，一行一个样本
% mat_sv： 支持向量矩阵，一行一个样本，列是维数
% vec_alpha：支持向量权重α，一个列向量
% b： 截距，一个标量

% b_tempor = - sum( (repmat(vec_alpha,1,size(mat_sv,2)) .* mat_sv ) *X' ); % b_tempor in 1xN
b_tempor =  vec_alpha'*mat_sv * X'; % 1xN
b = b_tempor';

end %function
function [vec_pre] = svmlpre(X, mat_sv, vec_alpha, b)

% 根据训练好的支持向量、α及截距，预测X类标号的函数
% X：无label的矩阵，一行一个样本,NxD
% mat_sv： 支持向量矩阵，一行一个样本，列是维数, vxD
% vec_alpha：支持向量权重α，一个列向量,vx1
% b： 截距，一个标量
% vec_pre：一个预测向量，每个元素是对X对应样本label的预测，一个预测是： one_pre = sum(alpha*k(vc*x))+b

vec_b = b * ones(1,size(X,1)); % vec_b in 1xN 
% vec_tempor = sum( (repmat(vec_alpha,1,size(mat_sv,2)) .* mat_sv ) *X' ) + vec_b;
vec_tempor = - vec_alpha' * mat_sv  * X' + vec_b;
vec_pre = vec_tempor';  

end%function
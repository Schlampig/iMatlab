function [new_D] = get_new_D( D, a, e_vec)

% AdaBoost训练中用来更新分布权重D的函数
% D：列向量，当前N个样本的权重
% e_vec：列向量，当前N个样本的验证错误率
% a：标量，当前基分类器的权重

new_D = [];
for i = 1:length(D)
    if e_vec(i) == 0 % h(x) = f(x)
        new_D = [new_D; D(i)*exp(-a)];
    else 
        new_D = [new_D; D(i)*exp(a)];
    end%if
end%for
new_D = new_D ./ sum(new_D); % Normalization

end % function
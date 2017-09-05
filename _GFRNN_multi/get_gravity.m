function [pre_label] = get_gravity(mat_mass,vec_mass,c)


% 利用引力原理对候选样本加权并预测类别
% pre_label：类别标记，一个正数
% mat_mass：第一列是候选样本的距离，第二列是候选样本的类别标记
% vec_mass：列向量，存放每个类样本的mass
% c：总类别数

vec_vote = [];
for i = 1:c
    temp_dist = mat_mass(find(mat_mass(:,2)==i),1);
    temp_f = vec_mass(i)*sum(1./ (temp_dist.^2)); % sum（m_c/ d^2）
    vec_vote = [vec_vote;temp_f];   
    clear temp_dist;clear temp_f;
end%for_i

temp_label = find(vec_vote == max(vec_vote)); % 找出产生引力最大的那个类
if length(temp_label) > 1 %无法判断到底是哪一类
    pre_label = 0;
else
    pre_label = temp_label;
end%if

end% function
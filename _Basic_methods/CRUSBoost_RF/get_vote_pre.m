function [winner] = get_vote_pre(candi_vec,fea_vec,c)

% candi_vec:候选行向量，适合label={1,2,3....}
% fea_vec：权重行向量
% c:类总数
% winner:标量，经过票数统计后，最终预测的类别

box_vec = zeros(c,1);

for i = 1:length(candi_vec)
    box_vec(candi_vec(i)) = box_vec(candi_vec(i)) + fea_vec(i);
end%for_i

candi_winner = find(box_vec == max(box_vec));
if length(candi_winner) > 1 % 找出得票数最多的那个类，如果不唯一则无法判断到底是哪一类
    winner = 0;
else
    winner = candi_winner;
end%if

end%function
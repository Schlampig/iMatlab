function [pre_label] = get_final_pre(data, c)

% 根据得分矩阵投票选出最后预测的类别标记
% data：一列一个model对所有data的预测，最后一行是置信度权重
% c:类别数

pre_label = [];
for i = 1:size(data,1)-1
    now_label = get_vote_pre(data(i,:),data(end,:),c);
    pre_label = [pre_label;now_label];
end%for_i_c

end %function
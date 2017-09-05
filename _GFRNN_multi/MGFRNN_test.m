function [vec_res] = MGFRNN_test(test_all, train_all, model)


% MGFRNN的测试过程，需要训练数据参与
% test_all：一行一个样本，最后一列是类别标记
% m：列向量，存放每个类样本的mass
% r：固定半径近邻所选择的半径
% c：训练样本集类别数
% s：训练样本总数

% 传递参数
s = model.s;
c = model.c;
r = model.r;
vec_mass = model.m;

% 预处理
test_num = size(test_all,1); % 测试样本总数
label_train = train_all(:,end); % 训练样本类别标记 
label_test = test_all(:,end); % 测试样本类别标记
label_pre = [];

for i_test = 1:test_num
    vec_dist = get_dist(train_all(:,1:end-1),test_all(i_test,1:end-1),s,1);
    candi_index = find(vec_dist <= r); % 在半径r以内的训练样本构成候选向量index
    mat_mass = [vec_dist(candi_index),label_train(candi_index)]; % 第一列是候选样本的距离，第二列是候选样本的类别标记
    pre_now = get_gravity(mat_mass,vec_mass,c); % 根据训练时得到的数据和类别标记预测当前测试样本的类别标记
    label_pre = [label_pre;pre_now];
end%for_i_test

cmp_label = label_pre - label_test;
cmp_label(find(cmp_label~=0)) = 1; % 把预测错误的样本设置为1，正确的为0

res_temp = [];
for i_c = 1:c
    cmp_now = cmp_label(find(label_test ==  i_c));
    AA_now = 1 - sum(cmp_now)/length(cmp_now); % 第i_c个类的预测正确率
    res_temp = [res_temp;AA_now];
end%for_i_c
Acc = (1 - sum(cmp_label)/test_num)*100; % 总分类精确度
AA = mean(res_temp)*100; % 算术平均正确率
GM = prod(res_temp).^(1/c)*100;%几何平均正确率
All = 0.5*(Acc+AA); % Acc与AA的值

vec_res = [-1,-1,-1,-1,Acc,AA,GM,All];

end%function



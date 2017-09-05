D_all = dir('PIE\*');%指定一个文件夹
num_file = 28;%当前文件夹下文件个数

num_class = [];%初始化
Acc = [];
AUC = [];
Acc_std = [];
AUC_std = [];
for i_all = 3:num_file+2%读取单类的结果
    load(['PIE\',D_all(i_all).name]);%载入指定文件夹下第i_all个文件（.mat已经含在文件名内）
    disp([num2str(i_all - 2),' ',D_all(i_all).name]);
    num_class = [num_class;1];
    Acc = [Acc;final_mat(end-2,end)];%当前数据结果的Acc
    AUC = [AUC;final_mat(end-1,end)];%当前数据结果的AUC
    Acc_std = [Acc_std; std(final_mat(end-2,1:end-1))];%十轮Acc的均方误差
    AUC_std = [AUC_std; std(final_mat(end-1,1:end-1))];%十轮AUC的均方误差
end%end_for_i_all
Res = [AUC,Acc,AUC_std,Acc_std];

save(['Res_show_PIE.mat'],'Res');
clear all;
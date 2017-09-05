D_all = dir('YaleB\*');%指定一个文件夹
num_file = 72;%当前文件夹下文件个数

num_class = [];%初始化
AUC = [];
AUC_row = [];
data_name = [];
for i_all = 3:num_file+2%读取单类的结果
    load(['YaleB\',D_all(i_all).name]);%载入指定文件夹下第i_all个文件（.mat已经含在文件名内）
    disp([num2str(i_all - 2),' ',D_all(i_all).name]);
    if isempty(data_name) == 0
        if data_name ~= D_all(i_all).name(5)%去掉数据结果文件头共同的kNN_这4个字符，第5个字符识别不同算法名
            AUC = [AUC;AUC_row];%每行一个算法，每列一个参数变换（这里是a的值）
            AUC_row = [];
        end
    end
    AUC_row = [AUC_row,final_mat(end-1,end)];%当前数据结果的AUC
    data_name = D_all(i_all).name(5);
    
end%end_for_i_all
AUC = [AUC;AUC_row];%最后一个算法的所有数据

save(['AUC_result_for_','YaleB','.mat'],'AUC');
clear all;
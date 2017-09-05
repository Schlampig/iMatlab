%addpath(genpath(pwd))

dir_name = 'BERL';
f = dir(dir_name);
all_data = size(f,1);%当前文件夹下子文件夹数



Res_AUC = [];%存放f文件夹下各子文件夹的各种数据
Res_Gmean = [];
Res_AUCstd = [];
Res_Gmeanstd = [];
for i_data = 3:all_data % 1与2是上一文件夹及当前文件夹路径，跳过
    name = f(i_data,1).name;%获得第i_data子文件夹名字
    disp(name);  % 屏幕上打印子文件夹名称
    D_all = dir([dir_name,'\',name,'\*']);%指定一个文件夹
    num_file = size(D_all,1);%当前文件夹下文件个数   

    AUC = [];
    Gmean = [];
    AUC_std = [];
    Gmean_std = [];
    
    for i_all = 3:num_file %读取单类的结果
        load([dir_name,'\',name,'\',D_all(i_all,1).name]);
%         if i_data == all_data
%             disp([num2str(i_all - 2),' ',D_all(i_all,1).name]); % 屏幕上打印算法名称
%         end%if
        AUC = [AUC;final_res(end-1,8)];%当前数据结果的Gmean和AUC
        Gmean = [Gmean;final_res(end-1,7)];
        AUC_std = [AUC_std;final_res(end,8)];%五轮AUC/Gmean的均方误差
        Gmean_std = [Gmean_std; final_res(end,7)];
    end%end_for_i_all
    
    Res_AUC = [Res_AUC,AUC];
    Res_Gmean = [Res_Gmean,Gmean];
    Res_AUCstd = [Res_AUCstd,AUC_std];
    Res_Gmeanstd = [Res_Gmeanstd,Gmean_std];

end%for_i_data

%^按照论文中数据集的顺序排列
vec_sort = [21;15;23;17;16;12;24;10;6;5;22;7;8;28;9;13;14;4;31;11;3;2;30;25;18;29;26;27;19;20;1]; 
Res_AUC = Res_AUC(vec_sort,:);
Res_Gmean = Res_Gmean(vec_sort,:);
Res_AUCstd = Res_AUCstd(vec_sort,:);
Res_Gmeanstd = Res_Gmeanstd(vec_sort,:);

save(['All_res_',dir_name,'.mat'],'Res_AUC','Res_Gmean','Res_AUCstd','Res_Gmeanstd');


clear all;



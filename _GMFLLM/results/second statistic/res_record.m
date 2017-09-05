function res_record

    directory = dir;%当前文件夹的结构体

    Acc_mat = [];%存放所有目录下所有数据结果的矩阵，每列一个目录
    AUC_mat = [];
    Acc_std_mat = [];
    AUC_std_mat = [];
    file_index = 3:(length(directory)-3);% 选择使用的文件并调整顺序
    
    for i_file = 1:length(file_index)  
               
        dir_name = [directory(file_index(i_file)).name,'\']; % 当前文件夹下的第i_file个文件夹的名字
        d_all = dir([dir_name,'*']);
%         data_index = 2 + [1;2;4;7;10;14;15;16;17;20;21;33;34;37;42;51;52;56;57;58;61;[64:73]'];
        data_index = 3:length(d_all); % 选择使用的数据集并调整顺序，默认3：length(d_all)
        
        Acc_vec = [];%当前目录下的所有数据结果向量，一个结果一行
        AUC_vec = [];
        Acc_std_vec = [];
        AUC_std_vec = [];
           
        for i_dataset = 1:length(data_index) %排除1与2，即根目录名及当前目录名
            
            load([dir_name,d_all(data_index(i_dataset)).name]);
            if i_file == 1 % 第一个文件  
                disp(d_all(data_index(i_dataset)).name);
            end%if  
            
            Acc_vec = [Acc_vec;final_mat(end-2,end)];
            AUC_vec = [AUC_vec;final_mat(end-1,end)];
            Acc_std_vec = [Acc_std_vec;std(final_mat(end-2,1:end-1))];
            AUC_std_vec = [AUC_std_vec;std(final_mat(end-1,1:end-1))];
            
        end%for_i_dataset

        Acc_mat = [Acc_mat,Acc_vec];
        AUC_mat = [AUC_mat,AUC_vec];
        Acc_std_mat = [Acc_std_mat,Acc_std_vec];
        AUC_std_mat = [AUC_std_mat,AUC_std_vec];
        
        disp(directory(file_index(i_file)).name); % 显示文件夹顺序
        
    end%for_i_file
    
    

    save('Res_LPP.mat','Acc_mat','AUC_mat','Acc_std_mat','AUC_std_mat')
    clear all;
    
end%function



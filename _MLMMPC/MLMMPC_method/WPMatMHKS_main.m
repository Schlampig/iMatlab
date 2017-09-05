function WPMatMHKS_main(file_name,datanum,ktimes,ratio,C,lam,u,b,wpc)

%注意：超出范围的设置没有报错机制。
%ktimes：MCCV迭代次数（1,2,3,...,10）
%ratio：训练数量比（0.1,0.2,0.3,...,0.9）
%C:松弛因子1
%lam:松弛因子2
%u:初始值
%b:初始值
%M_row：矩阵化的行数
%M_col：矩阵化的列数


switch datanum %根据数据集标号选择数据集 
    case 1
        load iris_all.mat;
        dataname = 'iris';
    case 2
        load coil_20_all.mat;
        dataname = 'coil20';
    case 3
        load letter_all.mat;
        dataname = 'letter';
    case 4
        load orl_faces_all.mat;
        dataname = 'orl_faces';
    case 5
        load Yale_32x32_all.mat;
        dataname = 'Yale';
    case 6
        load YaleB_32x32_all.mat;
        dataname = 'YaleB';
    case 7
        load breast_cancer_wisconsin_all.mat;
        dataname = 'breast_cancer_wisconsin';
    case 8
        load dermatology_all.mat;
        dataname = 'dermatology';
    case 9
        load glass_all_new.mat;
        dataname = 'glass_new';
    case 10
        load horse_colic_all.mat;
        dataname = 'horse_colic';
    case 11
        load lenses_all.mat;
        dataname = 'lenses';
    case 12
        load mammographic_masses_all.mat;
        dataname = 'mammographic_masses';
    case 13
        load seeds_all.mat;
        dataname = 'seeds';
    case 14
        load transfusion_all.mat;
        dataname = 'transfusion';
    case 15
        load VertebralColumn_all.mat;
        dataname = 'VertebralColumn_all';
    case 16
        load water_all.mat;
        dataname = 'water';
    case 17
        load wine_all.mat;
        dataname = 'wine';
    case 18
        load house_votes_all.mat;
        dataname = 'house_votes';
    case 19
        load sonar_all.mat;
        dataname = 'sonar';
    case 20
        load secom_all.mat;
        dataname = 'secom';  
    case 21
        load cmc_all.mat;
        dataname = 'cmc';
    case 22
        load housing_all.mat;
        dataname = 'housing';
    case 23
        load ionosphere_all.mat;
        dataname = 'ionosphere';
    case 24
        load Repair_pima_all.mat;
        dataname = 'pima';
    case 25
        load segment_all.mat;
        dataname = 'segment';
    case 26
        load semeion_all.mat;
        dataname = 'semeion';
    case 27
        load page_blocks_all.mat;
        dataname = 'page_blocks';        
    otherwise
        disp('You have input wrong dataset number!');%报错 
end%end_switch_dataset_kind

% %属性依照维数归一化（不是全局）
% A = max(data,[],2) - min(data,[],2);
% B = repmat(min(data,[],2),1,size(data,2));
% D = repmat(A,1,size(data,2));
% data = (data-B)./D;
% clear A;clear B;clear D;

%将需要用到的参数都放一个结构体中
InputPar.C = C;
InputPar.lam = lam;
InputPar.u = u;
InputPar.b = b;

[mat_sample_way,mat_sample_num]=Matrixlize_fun(data(:,1));%矩阵化，[矩阵化以后的组合方式，组合方式的个数]=计算矩阵化组合数目的函数(temptvec_data)

file_id = fopen(file_name, 'w');

fprintf(file_id, 'Setting: MCCV_Time-%.1f ,Training_Ratio(Beta)-%.1f ,C-%.3f ,Lamda-%.3f , WPC-%.3f ,Dataset-%s \r\n', ktimes,ratio,C,lam,wpc,dataname);
disp(['Setting: MCCV_Time-',num2str(ktimes),', Training_Ratio(Beta)-',num2str(ratio),' ,C-',num2str(C),' ,Lamda-',num2str(lam),' ,WPC-',num2str(wpc),' ,Dataset-',dataname]);%打印在屏幕上
fprintf(file_id,'--------------------------------------\r\n');%分隔符
disp(['--------------------------------------']);
time = zeros(ktimes,1);%设立记录训练时间的向量

%计算类偏移量，第i类的偏移记录在bias_class(i)里
bias_class = zeros(length(unique(label)),1);
for i_label = 1:length(unique(label))
    i_label_tempt = find(label==unique(i_label));
    bias_class(i_label) = i_label_tempt(1);
end%for_i_label
bias_class = bias_class - 1;

sum_class = numel(unique(label));%求类总数

accuracy = zeros(ktimes,1);%记录精确度的向量

for i_matrix = 1:mat_sample_num%第i_matrix种矩阵化结果
    M_row = mat_sample_way(i_matrix,1);%当前矩阵化后矩阵的行数
    M_col = mat_sample_way(i_matrix,2);%当前矩阵化后矩阵的列数
    fprintf(file_id,'The  %.1fth matrix form with the row  %.1f and the column  %.1f: \r\n',i_matrix,M_row,M_col);%第i_matrix矩阵化，当前的矩阵化行列数为……
    disp(['The',num2str(i_matrix),'th matrix form with the row',num2str(M_row),'and the column',num2str(M_col),':']);
    for i_iter = 1:ktimes%第i_iter轮MCCV
    %类两两训练
    tic;%开始计算一次迭代的训练时间
        for i_classone = 1:(sum_class-1)
            for i_classtwo = (i_classone+1):sum_class
            
                sum_classone_sample = length(find(label==i_classone));%找出当前两类各自的样本数
                sum_classtwo_sample = length(find(label==i_classtwo));          
                train_classone_sample = round(sum_classone_sample*ratio);%四舍五入取整找出训练样本数
                train_classtwo_sample = round(sum_classtwo_sample*ratio);
                bias_classone = bias_class(i_classone);%获取当前类的偏移量
                bias_classtwo = bias_class(i_classtwo);
              
                train_classone_data = data(:,index_struct(i_iter,i_classone).index(1:train_classone_sample)+bias_classone);%设置训练样本
                train_classtwo_data = data(:,index_struct(i_iter,i_classtwo).index(1:train_classtwo_sample)+bias_classtwo);
                train_binary_data = [train_classone_data,train_classtwo_data]';
                train_classone_label = ones(train_classone_sample,1)*i_classone;%设置训练样本类标号
                train_classtwo_label = ones(train_classtwo_sample,1)*i_classtwo;
                train_binary_label = [train_classone_label;train_classtwo_label];
           
                %第i_iter次MCCV迭代，第i_classone类和第i_classtwo类参与训练后得到的WPMatMHKS数据存入PMatStruct(i_classone,i_classtwo).candidate内
                WPMatStruct(i_classone,i_classtwo).candidate = WPMatMHKS_fun(train_binary_data,train_binary_label,InputPar,M_row,M_col,wpc);%代入训练，返回u和v
            
                %清空
                clear sum_classone_sample;clear sum_classtwo_sample;
                clear train_classone_sample;clear train_classtwo_sample;
                clear bias_classone;clear bias_classtwo;
                clear train_classone_data;clear train_classtwo_data;clear train_binary_data;
                clear train_classone_label;clear train_classtwo_label;clear train_binary_label;

            end%for_i_classtwo
        end%for_i_classone  
    time(ktimes) = toc;%第ktimes次MCCV训练用时
    
        %测试
        %生成测试样本数据集test_data和对应的类标号test_label
        sum_classtempt_sample = length(find(label==1));
        test_classtempt_sample = sum_classtempt_sample - round(sum_classtempt_sample*ratio);
        test_data = data(:,index_struct(i_iter,1).index((sum_classtempt_sample-test_classtempt_sample+1):sum_classtempt_sample));
        test_label = 1*ones(test_classtempt_sample,1);
        clear sum_classtempt_sample; clear test_classtempt_sample;
        for i_test = 2:sum_class
            bias_classtempt = bias_class(i_test);%获取当前类的偏移量
            sum_classtempt_sample = length(find(label==i_test));
            test_classtempt_sample = sum_classtempt_sample - round(sum_classtempt_sample*ratio);
            test_data = cat(2,test_data,data(:,index_struct(i_iter,i_test).index((sum_classtempt_sample-test_classtempt_sample+1):sum_classtempt_sample)+bias_classtempt));
            test_label = cat(1,test_label,i_test*ones(test_classtempt_sample,1));
        end%for_i_test
        test_data_final = (test_data)';
    
        matrix_vote = zeros(length(test_label),1);%设置投票矩阵，每一列是一个Group候选，第1列是总票数统计
        for i_testone = 1:(sum_class-1)
            for i_testtwo = (i_testone+1):sum_class
                %依次代入两两类训练获得的数据进行测试          
                Group = WPMatMHKS_test(WPMatStruct(i_testone,i_testtwo).candidate,test_data_final,i_testone,i_testtwo,M_row,M_col);
                matrix_vote = cat(2,matrix_vote,Group);%加入候补
                clear Group;
            end%for_i_testtwo
        end%for_i_testone 

        i_candidate = (sum_class)*(sum_class-1)/2;
        for i_poll = 1:length(test_label)
            vector_vote = matrix_vote(i_poll,2:(i_candidate+1));
            matrix_vote(i_poll,1) = mode(vector_vote);
        end%for_i_poll
    
        accuracy(i_iter) = 100*(1-(length(find((test_label - matrix_vote(:,1))~=0))/length(test_label)));
    
        fprintf(file_id,'The present accuracy of %d iteration in MCCV is: %f; \r\n',i_iter,accuracy(i_iter));
        disp(['The present accuracy of ',num2str(i_iter),' iteration in MCCV is: ',num2str(accuracy(i_iter))]);%打印在屏幕上
    end%for_i_iter
    fprintf(file_id,'The average accuracy is: %f; \r\n',mean(accuracy));%ktimes轮均值
    disp(['The average accuracy is: ',num2str(mean(accuracy))]);%打印在屏幕上
    fprintf(file_id,'The std of accuracies is: %f; \r\n',std(accuracy));%ktimes轮均方差
    disp(['The std of accuracies is: ',num2str(std(accuracy))]);
    fprintf(file_id,'The average time(s) is: %f; \r\n',mean(time));%ktimes轮时间
    disp(['The average time(s) is: ',num2str(mean(time))]);
    fprintf(file_id,'--------------------------------------\r\n');%分隔符
    disp(['--------------------------------------']);
    clear accuracy;clear time;
end%for_i_matrix
    
    fclose(file_id);%关闭文件
    
clear;
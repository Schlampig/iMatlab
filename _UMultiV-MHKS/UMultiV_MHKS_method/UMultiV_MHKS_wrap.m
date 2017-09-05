function UMultiV_MHKS_wrap(datanum,ktimes,ratio,C,zet,gama,uscale)

%用来设置UMultiV_MHKS_main函数所需要的输入变量file_name,datanum,ktimes,ratio,C,zet,gama,uscale的函数。

% 完整格式：
% datanum = [0;1;2;3;4;5;6;7;8;9;10;11;12;13];
% ktimes = 10;
% ratio = [0.1;0.3;0.5;0.7];
% C = [0.1;1;10;0.01;100];
% zet = [0.1;1;10;0.01;100];
% gama = [0.1;1;10;0.01;100];
% uscale = [0.3,0.4,0.5,0.6,0.7];


for i_datanum = 1:length(datanum)
    switch datanum(i_datanum)%根据数据集标号选择数据集
        case 0
            dataname_data = 'UMultiV_MHKS_breast_cancer_wisconsin';   
        case 1
            dataname_data = 'UMultiV_MHKS_iris';
        case 2
            dataname_data = 'UMultiV_MHKS_cmc';
        case 3
            dataname_data = 'UMultiV_MHKS_sonar';
        case 4
            dataname_data = 'UMultiV_MHKS_lenses';
        case 5
            dataname_data = 'UMultiV_MHKS_glass';
        case 6
            dataname_data = 'UMultiV_MHKS_water';
        case 7
            dataname_data = 'UMultiV_MHKS_horse_colic';
        case 8
            dataname_data = 'UMultiV_MHKS_transfusion';   
        case 9
            dataname_data = 'UMultiV_MHKS_secom';
        case 10
            dataname_data = 'UMultiV_MHKS_house_votes';
        case 11
            dataname_data = 'UMultiV_MHKS_housing';
        case 12
            dataname_data = 'UMultiV_MHKS_ionosphere';
        case 13
            dataname_data = 'UMultiV_MHKS_Repair_pima';          
        otherwise
            disp('You have input wrong dataset number!');%报错 
    end%end_switch_dataset_kind
    for i_ratio = 1:length(ratio)
        dataname_ratio = strcat('_TrainRate_',num2str(ratio(i_ratio)));
        for i_C = 1:length(C)
            dataname_C = strcat('_C_',num2str(C(i_C)));
            for i_gama = 1:length(gama)
                dataname_gama = strcat('_gama_',num2str(gama(i_gama)));
                for i_zet = 1:length(zet)
                    dataname_zet = strcat('_zet_',num2str(zet(i_zet)));               
                    for i_uscale = 1:length(uscale)
                        dataname_uscale = strcat('_uscale_',num2str(uscale(i_uscale))); 
                        dataname_final = strcat(dataname_data,dataname_ratio,dataname_C,dataname_gama,dataname_zet,dataname_uscale,'.txt');%将不同组合的数据集名字，训练集规模，惩罚权重和sigma核参连起来成为新生成文件的名字，效果应该是：‘RBF_iris_TrainRate_0.5_C_1_gama_1_zet_1_uscale_0.5.txt’
                        UMultiV_MHKS_main(dataname_final,datanum(i_datanum),ktimes,ratio(i_ratio),C(i_C),zet(i_zet),gama(i_gama),uscale(i_uscale));
                    end%for_i_uscale
                end%for_i_zet
            end%for_i_gama
        end%for_i_C
    end%for_i_ratio
end%for_i_datanum




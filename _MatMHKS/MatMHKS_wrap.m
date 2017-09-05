function MatMHKS_wrap

%用来设置MatMHKS_main函数所需要的输入变量的函数。

% 完整格式：
% datanum = [0;1;2;3;4;5;6;7;8;9;10;11;12;13];
% ktimes = 10;
% ratio = [0.1;0.3;0.5;0.7];
% C = [0.1;1;10;0.01;100];
% u = 0.5;
% b = 10^(-6);

datanum = [25;31;32;27];
ktimes = 10;
ratio = [0.9;0.7;0.5;0.3;0.1];
C = 1;
u = 0.5;
b = 10^(-6);

for i_datanum = 1:length(datanum)
    switch datanum(i_datanum)%根据数据集标号选择数据集  
        case 1
            dataname_data = 'Mat_iris';
        case 2
            dataname_data = 'Mat_Coil20';
        case 3
            dataname_data = 'Mat_Letter';
        case 4
            dataname_data = 'Mat_ORL';
        case 5
            dataname_data = 'Mat_Yale';
        case 6
            dataname_data = 'Mat_YaleB';  
        case 7
            dataname_data = 'Mat_breast_cancer_wisconsin';
        case 8
            dataname_data = 'Mat_dermatology';
        case 9
            dataname_data = 'Mat_glass_new';
        case 10
            dataname_data = 'Mat_horse_colic';
        case 11
            dataname_data = 'Mat_lenses';
        case 12
            dataname_data = 'Mat_mammographic_masses';
        case 13
            dataname_data = 'Mat_seeds_all';
        case 14
            dataname_data = 'Mat_transfusion';
        case 15
            dataname_data = 'Mat_VertebralColumn_all';
        case 16
            dataname_data = 'Mat_water';
        case 17
            dataname_data = 'Mat_wine'; 
        case 18
            dataname_data = 'Mat_house_votes';
        case 19
            dataname_data = 'Mat_sonar';
        case 20
            dataname_data = 'Mat_secom'; 
        case 21
            dataname_data = 'Mat_cmc';
        case 22
            dataname_data = 'Mat_housing';
        case 23
            dataname_data = 'Mat_ionosphere';
        case 24
            dataname_data = 'Mat_pima';
        case 25
            dataname_data = 'Mat_segment';
        case 26
            dataname_data = 'Mat_semeion';
        case 27
            dataname_data = 'Mat_page_blocks';   
        case 28
            dataname_data = 'Mat_optdigits'; 
        case 29
            dataname_data = 'Mat_pendigits'; 
        case 30
            dataname_data = 'Mat_spambase'; 
        case 31
            dataname_data = 'Mat_statlog'; 
        case 32
            dataname_data = 'Mat_waveform';             
        otherwise
            disp('You have input wrong dataset number!');%报错 
    end%end_switch_dataset_kind
    for i_ratio = 1:length(ratio)
        dataname_ratio = strcat('_TrainRate_',num2str(ratio(i_ratio)));              
        for i_C = 1:length(C)
            dataname_C = strcat('_C_',num2str(C(i_C)));
            dataname_final = strcat(dataname_data,dataname_ratio,dataname_C,'.txt');%合成文件全名
            MatMHKS_main(dataname_final,datanum(i_datanum),ktimes,ratio(i_ratio),C(i_C),u,b);
        end%for_i_C
    end%for_i_ratio
end%for_i_datanum




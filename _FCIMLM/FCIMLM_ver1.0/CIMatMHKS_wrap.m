function CIMatMHKS_wrap

%用来设置MatMHKS_main函数所需要的输入变量的函数。

% 完整格式：
% datanum = [1;7;8;9;10;11;12;13;14;15;16;17;18;19;20];
% ktimes = 10;
% ratio = [0.1;0.3;0.5;0.7];
% C = [0.1;1;10;0.01;100];
% dc = [0.1;0.3;0.5;0.7;0.9];
% attr = [2;3;4];
% u = 1;
% b = 10^(-6);

% datanum = [1;7;8;9;10;11;12;13;14;15;16;17;18;19;20];
datanum = [22;23];
ktimes = 10;
ratio = 0.5;
u = 1;
b = 10^(-6);
C = 1;
attr = [1;5;9;13];
dc = 1;

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
            dataname_data = 'Mat_segment';
        case 22 
            dataname_data = 'Mat_semeion';
        case 23
            dataname_data = 'Mat_page_blocks';
        otherwise
            disp('You have input wrong dataset number!');%报错 
    end%end_switch_dataset_kind
    for i_ratio = 1:length(ratio)
        dataname_ratio = strcat('_TrainRate_',num2str(ratio(i_ratio)));              
        for i_C = 1:length(C)
            dataname_C = strcat('_C_',num2str(C(i_C)));
            for i_dc = 1:length(dc)
                dataname_dc = strcat('_dc_',num2str(dc(i_dc)));
                for i_attr = 1:length(attr)
                   dataname_attr = strcat('_attr_',num2str(attr(i_attr))); 
                   dataname_final = strcat(dataname_data,dataname_ratio,dataname_C,dataname_dc,dataname_attr,'.txt');%合成文件全名
                   CIMatMHKS_main(dataname_final,datanum(i_datanum),ktimes,ratio(i_ratio),C(i_C),dc(i_dc),attr(i_attr),u,b);
                end%for_i_attr
            end%for_i_dc
        end%for_i_C
    end%for_i_ratio
end%for_i_datanum




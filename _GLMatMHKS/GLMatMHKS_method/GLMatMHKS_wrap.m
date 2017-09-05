function GLMatMHKS_wrap

%用来设置GLMatMHKS_main函数所需要的输入变量的函数。

% 完整格式：
% datanum = [0;1;2;3;4;5;6;7;8;9;10;11;12;13];
% ktimes = 10;
% ratio = [0.1;0.3;0.5;0.7];
% k = 1;%最近邻
% C = [0.1;1;10;0.01;100];
% lam = [0.1;1;10;0.01;100];
% u = 0.5;
% b = 10^(-6);

datanum = [18;19;20];
ktimes = 10;
ratio = 0.5;
k = 1;%最近邻
C = 1;
lam = 1;
u = 0.5;
b = 10^(-6);

for i_datanum = 1:length(datanum)
    switch datanum(i_datanum)%根据数据集标号选择数据集  
        case 1
            dataname_data = 'GLMat_iris';
        case 2
            dataname_data = 'GLMat_Coil20';
        case 3
            dataname_data = 'GLMat_Letter';
        case 4
            dataname_data = 'GLMat_ORL';
        case 5
            dataname_data = 'GLMat_Yale';
        case 6
            dataname_data = 'GLMat_YaleB';  
        case 7
            dataname_data = 'GLMat_breast_cancer_wisconsin';
        case 8
            dataname_data = 'GLMat_dermatology';
        case 9
            dataname_data = 'GLMat_glass_new';
        case 10
            dataname_data = 'GLMat_horse_colic';
        case 11
            dataname_data = 'GLMat_lenses';
        case 12
            dataname_data = 'GLMat_mammographic_masses';
        case 13
            dataname_data = 'GLMat_seeds_all';
        case 14
            dataname_data = 'GLMat_transfusion';
        case 15
            dataname_data = 'GLMat_VertebralColumn_all';
        case 16
            dataname_data = 'GLMat_water';
        case 17
            dataname_data = 'GLMat_wine'; 
        case 18
            dataname_data = 'GLMat_house_votes';
        case 19
            dataname_data = 'GLMat_sonar';
        case 20
            dataname_data = 'GLMat_secom'; 
        otherwise
            disp('You have input wrong dataset number!');%报错 
    end%end_switch_dataset_kind
    for i_ratio = 1:length(ratio)
        dataname_ratio = strcat('_TrainRate_',num2str(ratio(i_ratio)));              
            for i_k = 1:length(k)
            	dataname_k = strcat('_k_',num2str(k(i_k))); 
                for i_C = 1:length(C)
                    dataname_C = strcat('_C_',num2str(C(i_C)));
                    for i_lam = 1:length(lam)
                        dataname_lam = strcat('_lam_',num2str(lam(i_lam)));
                        dataname_final = strcat(dataname_data,dataname_ratio,dataname_k,dataname_C,dataname_lam,'.txt');%合成文件全名
                        GLMatMHKS_main(dataname_final,datanum(i_datanum),ktimes,ratio(i_ratio),k(i_k),C(i_C),lam(i_lam),u,b);
                    end%for_i_lam
                end%for_i_C
            end%for_i_k
    end%for_i_ratio
end%for_i_datanum




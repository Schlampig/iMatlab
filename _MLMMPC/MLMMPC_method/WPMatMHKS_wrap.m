function WPMatMHKS_wrap

%用来设置WPMatMHKS_main函数所需要的输入变量的函数。

% 完整格式：
% datanum = [0;1;2;3;4;5;6;7;8;9;10;11;12;13];
% ktimes = 10;
% ratio = [0.1;0.3;0.5;0.7];
% k = 1;%最近邻
% C = [0.1;1;10;0.01;100];
% lam = [0.1;1;10;0.01;100];
% u = 0.5;
% b = 10^(-6);
% wpc = [1;2;3];
% beta = [0.1;1;10];

datanum = [20;23;25];
ktimes = 10;
ratio = 0.5;
C = 1;
lam = 1;
wpc = [0.01;0.1;1;10;100;1000];
u = 1;
b = 10^(-6);


for i_datanum = 1:length(datanum)
    switch datanum(i_datanum)%根据数据集标号选择数据集  
        case 1
            dataname_data = 'WPMat_iris';
        case 2
            dataname_data = 'WPMat_Coil20';
        case 3
            dataname_data = 'WPMat_Letter';
        case 4
            dataname_data = 'WPMat_ORL';
        case 5
            dataname_data = 'WPMat_Yale';
        case 6
            dataname_data = 'WPMat_YaleB';  
        case 7
            dataname_data = 'WPMat_breast_cancer_wisconsin';
        case 8
            dataname_data = 'WPMat_dermatology';
        case 9
            dataname_data = 'WPMat_glass_new';
        case 10
            dataname_data = 'WPMat_horse_colic';
        case 11
            dataname_data = 'WPMat_lenses';
        case 12
            dataname_data = 'WPMat_mammographic_masses';
        case 13
            dataname_data = 'WPMat_seeds_all';
        case 14
            dataname_data = 'WPMat_transfusion';
        case 15
            dataname_data = 'WPMat_VertebralColumn_all';
        case 16
            dataname_data = 'WPMat_water';
        case 17
            dataname_data = 'WPMat_wine'; 
        case 18
            dataname_data = 'WPMat_house_votes';
        case 19
            dataname_data = 'WPMat_sonar';
        case 20
            dataname_data = 'WPMat_secom'; 
        case 21
            dataname_data = 'WPMat_cmc';
        case 22
            dataname_data = 'WPMat_housing';
        case 23
            dataname_data = 'WPMat_ionosphere';
        case 24
            dataname_data = 'WPMat_pima';
        case 25
            dataname_data = 'WPMat_segment';
        case 26
            dataname_data = 'WPMat_semeion';
        case 27
            dataname_data = 'WPMat_page_blocks'; 
        otherwise
            disp('You have input wrong dataset number!');%报错 
    end%end_switch_dataset_kind
    for i_ratio = 1:length(ratio)
        dataname_ratio = strcat('_TrainRate_',num2str(ratio(i_ratio)));               
        for i_C = 1:length(C)
            dataname_C = strcat('_C_',num2str(C(i_C)));
            for i_lam = 1:length(lam)
                dataname_lam = strcat('_lam_',num2str(lam(i_lam)));
                for i_wpc = 1:length(wpc)
                    dataname_wpc = strcat('_wpc_',num2str(wpc(i_wpc)));
                    dataname_final = strcat(dataname_data,dataname_ratio,dataname_C,dataname_lam,dataname_wpc,'.txt');%合成文件全名
                    WPMatMHKS_main(dataname_final,datanum(i_datanum),ktimes,ratio(i_ratio),C(i_C),lam(i_lam),u,b,wpc(i_wpc));
                end%for_i_wpc
            end%for_i_lam
        end%for_i_C
    end%for_i_ratio
end%for_i_datanum




function K3PILD_wrap

%用来设置LDNN_main函数所需要的输入变量的函数。

dataset_name = 'Imbalanced_data_v2.mat';
ktimes = 5; % 5FCV,fixed
% index = [3;4;6;9;11;17;18;19;21;22;23;24;31;35;37;39;41;45;49;50;53;55;59;60;61;62;64]; % for Imbalanced_data
index = [1;7;8;9]; % for Imbalanced_data_v2
dp = 2;
ker_par = [0.01;0.1;1;10;100];
ker_type = 'rbf';

for i_index = 1:length(index) 
    for i_dp = 1:length(dp)
        for i_ker = 1:length(ker_par)
            Par.dp = dp(i_dp);
            Par.ker_par = ker_par(i_ker);
            Par.ker_type = ker_type;
            K3PILD_main(dataset_name, index(i_index),ktimes,Par);
        end%for_i_ker
    end%for_i_dp
end%for_i_index

end
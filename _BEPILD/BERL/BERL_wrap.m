function BERL_wrap

%用来设置BERL_main函数所需要的输入变量的函数。

dataset_name = 'Imbalanced_data.mat';
ktimes = 5; % 5FCV,fixed
index = [3;4;6;9;11;17;18;19;21;22;23;24;31;35;37;39;41;45;49;50;53;55;59;60;61;62;64]; % for Imbalanced_data
% index = [1;7;8;9]; % for Imbalanced_data_v2

for i_index = 1:length(index) 
    BERL_main(dataset_name, index(i_index),ktimes);
end%for_i_index

end
function MGFRNN_wrap

%用来设置MGFRNN_main函数所需要的输入变量的函数。

dataset_name = 'KEEL';
ktimes = 5; % 5FCV,fixed
index = 1:50;

for i_index = 1:length(index)
    MGFRNN_main(dataset_name, index(i_index),ktimes);
end%for_i_index

end
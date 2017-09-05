function CRUSRF_Wrap

%用来设置CRUSRF函数所需要的输入变量的函数。


dataset_name = 'KEEL';
% index = [18;20;61;62;64;69;71;73];% 选择数据集
% index = [25;26;36;48;59;66;72;74];
index = [45];%[17;19;21;22;24;37;39;41;45]
ktimes = 5; % 5FCV,fixed
T = [5;10;30;50;100];
k = [3;5;7;9];



for i_index = 1:length(index) 
    for i_k =  1:length(k)
        for i_T = 1:length(T)
            CRUSRF(dataset_name, index(i_index), ktimes, k(i_k), T(i_T));
        end%for_i_k
    end%for_i_T
end%for_i_index

end
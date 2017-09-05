function RF_Wrap

%用来设置RF函数所需要的输入变量的函数。


dataset_name = 'KEEL';
% index = [18;20;61;62;64;69;71;73];% 选择数据集
% index = [25;26;36;48;59;66;72;74];
index = [17;19;21;22;24;37;39;41;45];
ktimes = 5; % 5FCV,fixed
nT = [5;10;30;50;100];



for i_index = 1:length(index)           
    for i_nT = 1:length(nT)
        RF(dataset_name, index(i_index), ktimes, nT(i_nT));
    end%for_i_C
end%for_i_index

end
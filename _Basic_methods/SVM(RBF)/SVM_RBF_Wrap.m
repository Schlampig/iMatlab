function SVM_RBF_Wrap

%用来设置SVM_RBF函数所需要的输入变量的函数。


dataset_name = 'KEEL';
% index = [18;20;61;62;64;69;71;73]; % 选择数据集
% index = [25;26;36;48;59;66;72;74];
index = [17;19;21;22;24;37;39;41;45];
ktimes = 5; % 5FCV,fixed
% % Heart的设置
% C = [6;8;10];
% sigma = [10;50;55;60;65;100];
% KEEL的设置
C = [1;10;50;100;0.1];
sigma = [0.01;0.1;1;10;100];


for i_index = 1:length(index)           
    for i_C = 1:length(C)
        for i_sigma = 1:length(sigma)
            SVM_RBF(dataset_name, index(i_index), ktimes, C(i_C), sigma(i_sigma));
        end%for_i_sigma
    end%for_i_C
end%for_i_index

end
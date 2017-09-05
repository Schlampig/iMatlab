function SMOTE_PILD_wrap

%用来设置SMOTE_PILD_main函数所需要的输入变量的函数。
%注意这里的smote是生成样本的倍数，而不是ksmote(使用smote的近邻数)，
%smote默认为2倍，ksmote默认为3，
%注意，选用的原始数据集的不平衡率应当高于smote值(在main函数中有体现)。

% index = [1;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24;25;26];
index = 60;
ktimes = 5;
dp = 2;
beta = 2;

for i_index = 1:length(index) 
    for i_dp = 1:length(dp)
        for i_beta = 1:length(beta)
        	SMOTE_PILD_main(index(i_index),ktimes,dp(i_dp),beta(i_beta));
        end%for_i_smote
    end%for_i_dp
end%for_i_index

end
function SMOTE_PILDC_wrap

%用来设置SMOTE_PILDC_wrap函数所需要的输入变量的函数。

% index = [1;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24;25;26];
index = 64;
ktimes = 5;
dp = 2;
beta = 1;


for i_index = 1:length(index) 
    for i_dp = 1:length(dp)
        for i_beta = 1:length(beta)
            SMOTE_PILDC_main(index(i_index),ktimes,dp(i_dp),beta(i_beta));
        end%for_i_beta
    end%for_i_dp
end%for_i_index

end
function MTFLD_wrap

%用来设置MTFLD_main函数所需要的输入变量的函数。

dataset_name = 'KEEL';
ktimes = 5; % 5FCV,fixed
index = 1:75;
dp = 2;
reg = 0;
theta = 2:11;%阈值编号


for i_index = 1:length(index) 
    for i_dp = 1:length(dp)
        for i_reg = 1:length(reg)
            for i_theta = 1:length(theta)
                MTFLD_main(dataset_name,index(i_index),ktimes,dp(i_dp),reg(i_reg),theta(i_theta));
            end%for_i_theat
        end%for_i_reg
    end%for_i_dp
end%for_i_index

end%function
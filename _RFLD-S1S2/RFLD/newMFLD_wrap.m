function newMFLD_wrap

%用来设置newMFLD_main函数所需要的输入变量的函数。

dataset_name = 'KEEL';
ktimes = 5; % 5FCV,fixed
index = 1:75;
dp = 2;
reg = 0;
k = [1;3;5;7;9];
c = [0.1;0.9];

for i_index = 1:length(index) 
    for i_dp = 1:length(dp)
        for i_reg = 1:length(reg)
            for i_c = 1:length(c)
                for i_k = 1:length(k)
                    newMFLD_main(dataset_name,index(i_index),ktimes,dp(i_dp),reg(i_reg),k(i_k),c(i_c));
                end%for_i_k
            end%for_i_c
        end%for_i_reg
    end%for_i_dp
end%for_i_index

end%function
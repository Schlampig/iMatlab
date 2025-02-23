function MTMFLD_wrap

%用来设置MTMFLD_main函数所需要的输入变量的函数。

dataset_name = 'KEEL';
ktimes = 5; % 5FCV,fixed
index = 1:75;
% index = [3;4;6;9;11;17;18;19;21;22;23;24;31;35;37;39;41;45;49;50;53;55;59;60;61;62;64;65;71;72;73];
dp = 2;
reg = 0;
theta = 2:11;%阈值编号
% c = [0;0.3;0.5;0.7;1];
c = [0.1;0.9];
% k = [1;3;5];
k = [1;3;5;7;9];

for i_index = 1:length(index) 
    for i_dp = 1:length(dp)
        for i_reg = 1:length(reg)
            for i_c = 1:length(c)
                for i_k = 1:length(k)
                    MTMFLD_main(dataset_name,index(i_index),ktimes,dp(i_dp),reg(i_reg),c(i_c),theta,k(i_k));
                end%for_i_k
            end%for_i_c
        end%for_i_reg
    end%for_i_dp
end%for_i_index

end%function
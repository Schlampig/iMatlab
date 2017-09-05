function K1PILD_wrap

%用来设置K1PILD_main函数所需要的输入变量的函数。

dataset_name = 'Imbalanced_data_v2.mat';
ktimes = 5; % 5FCV,fixed
% index = [3;4;6;9;11;17;18;19;21;22;23;24;31;35;37;39;41;45;49;50;53;55;59;60;61;62;64]; % for Imbalanced_data
index = [1;7;8;9]; % for Imbalanced_data_v2
dp = 2;
reg = 0;
kpar = [0.01;0.1;1;10;100];
ktype = 'rbf'; % or 'lin' etc.

for i_index = 1:length(index) 
    for i_dp = 1:length(dp)
        for i_reg = 1:length(reg)
            for i_kpar = 1:length(kpar)
                par.dp = dp(i_dp);
                par.reg = reg(i_reg);
                par.ktype = ktype;
                par.kpara = kpar(i_kpar);
                K1PILD_main(dataset_name, index(i_index), ktimes, par);
            end%for_i_kpar
        end%for_i_reg
    end%for_i_dp
end%for_i_index

end
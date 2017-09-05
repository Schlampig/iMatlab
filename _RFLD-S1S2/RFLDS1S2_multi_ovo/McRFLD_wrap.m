function McRFLD_wrap

% 设置参数的函数

% 数据集参数
dataname = {'UCI5cv'};
fileindex = 1:22;
ktimes = 5;
modelname = {'RFLD'}; % RFLD, RFLDS1, RFLDS2

% 模型参数
dp = 2;
reg = 0;
k = [1;3;5;7;9];
c = [0;0.3;0.5;0.7;1];
theta = 2:11;

for i_dataname = 1:length(dataname)
    for i_fileindex = 1:length(fileindex)
        disp(['Run the',num2str(fileindex(i_fileindex)),' dataset...']);
        disp('  ');
        for i_ktimes = 1:length(ktimes)
            for i_modelname = 1:length(modelname)
                for i_dp = 1:length(dp)
                    for i_reg = 1:length(reg)
                        for i_k = 1:length(k)
                            for i_c = 1:length(c)
                                par.dataname = dataname{i_dataname};
                                par.fileindex = fileindex(i_fileindex);
                                par.ktimes = ktimes(i_ktimes);
                                par.modelname = modelname{i_modelname};
                                par.dp = dp(i_dp);
                                par.reg = reg(i_reg);
                                par.k = k(i_k);
                                par.c = c(i_c);
                                if strcmp(modelname,'RFLDS1')
                                    for i_theta = 1:length(theta)
                                        par.theta = theta(i_theta);
                                        McRFLD_main(par);
                                    end %for_i_theta
                                else
                                    McRFLD_main(par);
                                end%if
                            end%for_i_c
                        end%for_i_k
                    end%for_i_reg
                end%for_i_dp
            end%for_i_modelname
        end%for_i_ktimes
    end%for_i_fileindex
end%for_i_dataname


end % function
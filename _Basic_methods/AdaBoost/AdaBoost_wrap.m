function AdaBoost_wrap

%用来设置AdaBoost_main函数所需要的输入变量的函数。

% 基础设置
dataset_name = 'KEEL';
index =  1:75;
par.ktimes = 5; % 10 or 5 FCV,fixed
model_name = 'CART';
par.model_name = model_name;
T = 10;

% classifier参数
if strcmp(model_name,'SVM_RBF')
    C = [0.1;1;10;50;100];
%     sigma = [2^-7;2^-6;2^-5;2^-4;2^-3;2^-2;2^-1;1;2;4;8;16;32;64;128;256];
    sigma = [0.01;0.1;1;10;30;50;100];
    maxtime = 100000;
elseif strcmp(model_name,'SVM_Linear')
    C = [0.1;1;10;50;100];
    sigma = 1;
    maxtime = 100000;
else
    C = 1;
    sigma = 1;
    maxtime = 1;
end%if_SVM(RBF/Linear)

if strcmp(model_name,'RF')
    tree = [5;10;30;50;100];
else
    tree = 1;
end%if_RF

% 配置参数并运行程序
for i_index = 1:length(index)
    for i_T = 1:length(T)
        for i_C = 1:length(C)
            for i_sigma = 1:length(sigma)
                for i_tree = 1:length(tree)
                    % AdaBoost参数
                    par.T = T(i_T);
                    % SVM参数
                    par.C = C(i_C);
                    par.sigma = sigma(i_sigma);
                    par.maxtime = maxtime;
                    % RF参数
                    par.tree = tree(i_tree);

                    %运行主程序
                    AdaBoost_main(dataset_name, index(i_index), par);
                end%tree
            end%sigma
        end%C
    end%T
end%for_i_index

end %function
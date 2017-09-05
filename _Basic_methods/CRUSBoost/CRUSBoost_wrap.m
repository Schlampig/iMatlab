function CRUSBoost_wrap

%用来设置CRUSBoost_main函数所需要的输入变量的函数。

% 基础设置
dataset_name = 'KEEL';
index =  64;
par.ktimes = 5; % 10 or 5 FCV,fixed
model_name = 'RF';
par.model_name = model_name;
T = [5;10;20];
k = [1;3;5];
ratio = [0;0.1;0.3];

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
    tree = [5;10;30];
else
    tree = 1;
end%if_RF

% 配置参数并运行程序
for i_index = 1:length(index)
    for i_T = 1:length(T)
        for i_k = 1:length(k)
            for i_ratio = 1:length(ratio)
                for i_C = 1:length(C)
                    for i_sigma = 1:length(sigma)
                        for i_tree = 1:length(tree)
                            % AdaBoost参数
                            par.T = T(i_T);
                            par.k = k(i_k); % 聚类个数
                            par.ratio = ratio(i_ratio);
                            % SVM参数
                            par.C = C(i_C);
                            par.sigma = sigma(i_sigma);
                            par.maxtime = maxtime;
                            % RF参数
                            par.tree = tree(i_tree);

                            %运行主程序
                            CRUSBoost_main(dataset_name, index(i_index), par);
                        end%tree
                    end%sigma
                end%C
            end%ratio
        end%k
    end%T
end%for_i_index

end %function
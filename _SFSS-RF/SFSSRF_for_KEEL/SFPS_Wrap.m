function SFPS_Wrap

%用来设置SFPS_main函数所需要的输入变量的函数。

% 基础设置
dataset_name = 'KEEL';
% index = [18;20;61;62;64;69;71;73;25;26;36;48;59;66;72;74];% 选择数据集
index = [17;19];
par.ktimes = 5; % 10 or 5 FCV,fixed
par.target = [0,0,0,1,0,0,0,0]; % 1-8分别是：TPR,TNR,PPV,F1,Acc,MAcc,GMean,0.5*(Acc+MAcc)

% 初始化参数
% SFPS参数
model = 2;
ratio = [0;0.1;0.3;0.5;0.7];
n_sample = [10;25;50];
n_window = 9;
n_step = 9 ;
% classifier参数
if model == 0
    C = [0.1;1;10;50;100];
%     sigma = [2^-7;2^-6;2^-5;2^-4;2^-3;2^-2;2^-1;1;2;4;8;16;32;64;128;256];
    sigma = [0.01;0.1;1;10;30;50;100];
    maxtime = 100000;
elseif model == 3
    C = [0.1;1;10;50;100];
    sigma = 1;
    maxtime = 100000;
else
    C = 1;
    sigma = 1;
    maxtime = 100000;
end%if_SVM(RBF/Linear)
if model == 1
    k = [1;3;5;7;9];
    metric = 0;
else
    k = 1;
    metric = 0;
end%if_kNN
if model == 2
    T = [5;10;20];
else
    T = 1;
end%if_RF

% 配置参数并运行程序
for i_index = 1:length(index)
    for i_model = 1:length(model)
        for i_ratio = 1:length(ratio)
            for i_sample = 1:length(n_sample)
               for i_window = 1:length(n_window)
                  for i_step = 1:length(n_step)
                      for i_C = 1:length(C)
                          for i_sigma = 1:length(sigma)
                              for i_k = 1:length(k)
                                  for i_metric = 1:length(metric)
                                      for i_T = 1:length(T)
                                          par.model = model(i_model);%选择模型
                                          par.ratio = ratio(i_ratio);%控制不平衡比例，介于0与1之间
                                          par.n_sample = n_sample(i_sample);%数据分块个数
                                          par.window = n_window(i_window); % 特征选择时的窗口大小
                                          par.step = n_step(i_step);% 特征选择时的步长
                                          % SVM参数
                                          par.C = C(i_C);
                                          par.sigma = sigma(i_sigma);
                                          par.maxtime = maxtime;
                                          % kNN参数
                                          par.k = k(i_k); 
                                          par.metric = metric(i_metric);
                                          % RF参数
                                          par.T = T(i_T);

                                          %运行主程序
                                          SFPS_main(dataset_name, index(i_index), par);
                                      end%T
                                  end%metric
                              end%k
                          end%sigma
                      end%C
                  end%step
               end%window
            end%sample
        end%ratio
    end%model
end%for_i_index

end %function
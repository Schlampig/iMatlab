function [clf, name] = model_train(data, par)

% 根据tag选择使用的模型对样本进行训练
% data:一行一个样本，最后一列是label
% clf:classifier，函数外训练好的模型


tag = par.model; % tag:用于选择用来测试的模型
switch tag
    case 0 % RBF支持向量机
        option=svmsmoset('MaxIter',par.maxtime);
        clf = svmtrain(data(:,1:end-1),data(:,end),'kernel_function','rbf','rbf_sigma',par.sigma,'method','SMO','boxconstraint',par.C,'SMO_OPTS',option);
        name = strcat('SVM_rbf_','_C',num2str(par.C),'_sigma',num2str(par.sigma),'_maxt',num2str(par.maxtime));
    case 1 % k近邻
        clf.c = length(unique(data(:,end))); % 总类数
        clf.k = par.k; % 近邻数
        clf.train_all = data; % 参与计算的样本
        clf.metric = par.metric; %选择度量方式
        name = strcat('kNN_k',num2str(par.k),'_metric',num2str(par.metric));
    case 2 % 随机森林
        clf = TreeBagger(par.T,data(:,1:end-1),data(:,end), 'Method', 'classification'); 
        name = strcat('RF_T',num2str(par.T));
    case 3 % 线性支持向量机
        option=svmsmoset('MaxIter',par.maxtime);
        clf = svmtrain(data(:,1:end-1),data(:,end),'kernel_function','linear','method','SMO','boxconstraint',par.C,'SMO_OPTS',option);
        name = strcat('SVM_linear_','_C',num2str(par.C),'_maxt',num2str(par.maxtime));
end%switch  


end % function
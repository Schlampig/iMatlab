function [clf, name] = model_train(data, par)

% 根据tag选择使用的模型对样本进行训练
% data:一行一个样本，最后一列是label
% clf:classifier，函数外训练好的模型

model_name = par.model_name; % tag:用于选择用来测试的模型
if strcmp(model_name,'ID3')
    clf = treefit(data(:,1:end-1),data(:,end),'method','classification');
    name = model_name;
elseif strcmp(model_name,'CART')
    clf = classregtree(data(:,1:end-1),data(:,end),'method','classification') ;
    name = model_name;
elseif strcmp(model_name,'SVM_RBF')
    option=svmsmoset('MaxIter',par.maxtime);
    clf = svmtrain(data(:,1:end-1),data(:,end),'kernel_function','rbf','rbf_sigma',par.sigma,'method','SMO','boxconstraint',par.C,'SMO_OPTS',option);
    name = strcat('SVM_RBF_','_C',num2str(par.C),'_sigma',num2str(par.sigma),'_maxt',num2str(par.maxtime));    
elseif strcmp(model_name,'SVM_Linear')
    option=svmsmoset('MaxIter',par.maxtime);
    clf = svmtrain(data(:,1:end-1),data(:,end),'kernel_function','linear','method','SMO','boxconstraint',par.C,'SMO_OPTS',option);
    name = strcat('SVM_Linear_','_C',num2str(par.C),'_maxt',num2str(par.maxtime));    
elseif strcmp(model_name,'RF')
    clf = TreeBagger(par.tree,data(:,1:end-1),data(:,end), 'Method', 'classification'); 
    name = strcat('RF_T',num2str(par.tree));
end%if
    

end % function
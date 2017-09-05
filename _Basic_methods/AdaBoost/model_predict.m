function [pre_label] = model_predict(data, clf, par)

% 根据tag选择使用的模型对样本进行测试
% data:一行一个样本，最后一列是label
% clf:classifier，函数外训练好的模型

model_name = par.model_name; % tag:用于选择用来测试的模型
if strcmp(model_name,'ID3')
    pre_label = treeval(clf,data(:,1:end-1));
elseif strcmp(model_name,'CART')
    pre_label = treeval(clf,data(:,1:end-1));
elseif strcmp(model_name,'SVM_RBF')
    pre_label = svmclassify(clf,data(:,1:end-1));    
elseif strcmp(model_name,'SVM_Linear')
    pre_label = svmclassify(clf,data(:,1:end-1));    
elseif strcmp(model_name,'RF')
    [~,p_mat] = clf.predict(data(:,1:end-1));
    [~, pre_label] = max(p_mat,[],2); % 找出每一行最大的那一列的标号，就对应类别标记
end%if
    

end%function 
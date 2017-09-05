function [pre_label] = model_predict(data, clf, tag)

% 根据tag选择使用的模型对样本进行测试
% data:一行一个样本，最后一列是label
% clf:classifier，函数外训练好的模型
% tag:用于选择用来测试的模型


switch tag
    case 0 % 支持向量机
        pre_label = svmclassify(clf,data(:,1:end-1));
    case 1 % k近邻
        pre_label = kNN_test(data, clf.train_all , clf.c, clf.k, clf.metric);
    case 2 % 随机森林
        [~,p_mat] = clf.predict(data(:,1:end-1));
        [~, pre_label] = max(p_mat,[],2); % 找出每一行最大的那一列的标号，就对应类别标记 
    case 3 % 支持向量机
        pre_label = svmclassify(clf,data(:,1:end-1));    
end%switch        

end%function 
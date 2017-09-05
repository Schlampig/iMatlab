function [method, candi_vec, basic_clf_name] = CRUSBoostRF_train(train_all, par)

% 训练CRUSBoost的函数，这个版本只能处理两类分类问题
% train_all: 训练集矩阵，一行一个样本，最后一列是label。

% 赋值
T =  par.T; % 迭代数=基分类器个数
N = size(train_all,1); % 样本总数

% 训练
D = 1/N * ones(N,1);
candi_vec = [];
threshold = 0; % 选择基分类器组合的评价标准，0-100
for i = 1:T
    train_sub = get_CRUS(train_all, par);
    [method(i).clf, basic_clf_name] = model_train(train_sub, par);
    [pre_label] = model_predict(train_all, method(i).clf, par);
    e_vec = (pre_label ~= train_all(:,end)); % 不等时为1，相等时为0
    e = sum(D.*e_vec);  
    if e == 0
        e = 0.000001;
    end%if
    method(i).a = 0.5*log((1-e)/e); % matlab里log()函数是计算自然对数，相当于ln
    
    res_now = Ada_select_test(train_all, method, par, [candi_vec, i]); % 以训练集当验证集
    if res_now(par.validation) > threshold
        threshold = res_now(par.validation);
        candi_vec = [candi_vec, i];
    end%if
    
    D = get_new_D( D, method(i).a, e_vec);
    clear e_vec; clear e;    
end%for

end % function
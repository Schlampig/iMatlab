function SMOTE_RF(dataset_name, data_index, ktimes, nT, ksmote)

%使用SMOTE预处理的随机森林分类器。
%超出范围的设置没有报错机制，看着办。
%ktimes：MCCV迭代次数（1,2,3,...,10）
%nT:森林里树的个数

% 预处理
load([dataset_name,'.mat']);
file_name = eval([dataset_name,'{',num2str(data_index),',1}']);
dataname =  strcat('SmoteRF_',file_name,'_T',num2str(nT),'_ksmote',num2str(ksmote));%转存的文件名
final_res = zeros(ktimes+2,8);%记录ktimes轮结果的矩阵,倒数第二行存均值，最后一行存std，每一列分别是TP,FP,TN,FN,acc,均值acc，gm,auc=

% 训练与测试
for i_cv = 1:ktimes    
    % 获得数据集（最后一列为类别标记）
    if strcmp(dataset_name,'KEEL')   
        train_orig = eval([dataset_name,'{',num2str(data_index),',3}{',num2str(i_cv),',1}']);
        test_all = eval([dataset_name,'{',num2str(data_index),',3}{',num2str(i_cv),',2}']);
        train_orig(:,end) = train_orig(:,end)+1; % label_pos = 2, label_neg =1
        test_all(:,end) = test_all(:,end)+1; 
    else
        train_orig = eval([dataset_name,'{',num2str(data_index),',2}{',num2str(i_cv),',1}']); % label_pos = 2, label_neg =1
        test_all = eval([dataset_name,'{',num2str(data_index),',2}{',num2str(i_cv),',2}']);
    end%if
    
    % SMOTE处理
    smote_Sample = [];
    Positive_Id = find(train_orig(:,end) == 2);%少数类个数
    Negative_Id = find(train_orig(:,end) == 1);%多数类个数
    if length(Negative_Id)/length(Positive_Id) >= 2; % 如果多数类个数比少数类个数多2倍以上
        beta = floor(length(Negative_Id)/length(Positive_Id)/2);% 将不平衡率控制在2以下
        smote_Sample = SMOTE_Fuc(train_orig(Positive_Id,1:end-1), ksmote, beta);
        smote_Sample = [smote_Sample,2*ones(size(smote_Sample,1),1)];
    end %if
    train_all = [train_orig;smote_Sample];
    c = max(train_all(:,end)); % 总类数
    
    % 训练
    forest = TreeBagger(nT,train_all(:,1:end-1),train_all(:,end), 'Method', 'classification');%代入训练
    
    % 测试
    [~,p_mat] = forest.predict(test_all(:,1:end-1)); 
    [~,label_pre] = max(p_mat,[],2); % 找出每一行最大的那一列的标号，就对应类别标记
    label_test = test_all(:,end);
    
    % 统计一轮的结果
    final_res(i_cv,:) = get_binary_evaluate(label_pre, label_test);

end%for_i_cv

final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
final_res(ktimes+2,:) = std(final_res(1:ktimes,:));

save([dataname,'.mat'],'final_res');

            
end
            
            


function DPILD_main(data_index,ktimes,dp_index)

%迭代伪逆算法

%dp_index:用来选择生成的dp（理想label）是怎样的

load Imbalanced_data.mat;
dataname =  strcat('PILD_dp_',num2str(dp_index),'_',Imbalanced_data{data_index,1});%转存的文件名
final_res = zeros(ktimes+2,8);%记录ktimes轮结果的矩阵,倒数第二行存均值，最后一行存std，每一列分别是TP,FP,TN,FN,acc,均值acc，gm,auc=
ir = Imbalanced_data{data_index,2};
for i_cv = 1:ktimes
   train_all = Imbalanced_data{data_index,3}{i_cv,1};
   test_all = Imbalanced_data{data_index,3}{i_cv,2};
   
   %迭代训练阶段
   [row_train,col_train] = size(train_all);
   train_neg = train_all(find(train_all(:,end)==0),:);%初始所有负类训练样本
   train_pos = train_all(find(train_all(:,end)==1),:);%初始所有正类训练样本
   %第一轮迭代
   [w,w0] = DPILD_train(train_all,dp_index);%第一轮得到的权重
   [vec_res] = DPILD_test(train_all,w,w0);
   Acc2 = vec_res(6);
   GM = vec_res(7); 
   %进一步迭代
   for i_max = 1:300%迭代上限
        if (size(train_pos,1)<2) || (size(train_neg,1)<2)%如果有一方样本数不足2个，停止
            break;
        else
            uneg = mean(train_all(find(train_all(:,end)==0),1:col_train-1),1)';%求当前训练样本正负类的均值点（质心），列向量
            upos = mean(train_all(find(train_all(:,end)==1),1:col_train-1),1)';
            value_neg = w'*uneg + w0;
            value_pos = w'*upos + w0;
            value_min = min([value_neg,value_pos]);
            value_max = max([value_neg,value_pos]);
            vec_sum = sum(repmat(w',size(train_all,1),1) .* train_all(:,1:col_train-1),2) + w0*ones(size(train_all,1),1);%求当前训练样本的w'*x，一列向量
            train_tempor = train_all(intersect(find(vec_sum>value_min),find(vec_sum<value_max)),:);%找出介于两质心间的样本作为下一轮的迭代
            clear train_all;
            train_all = train_tempor;       
            [w,w0] = DPILD_train(train_all,dp_index);%新权重计算
            [vec_res] = DPILD_test(train_all,w,w0);
            acc2 = vec_res(6);%新一轮acc2和gm
            gm = vec_res(7);
         end%end_size
         
         if (acc2 >= Acc2) && (gm>=GM)
             Acc2 = acc2;
             GM = gm;
             continue;
         else
             break;
         end%if_tag
      
    end%for_i_max
  
   [vec_res] = DPILD_test(test_all,w,w0);
   final_res(i_cv,:) = vec_res;  
end%for_i_cv
final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
final_res(ktimes+2,:) = std(final_res(1:ktimes,:));

save([dataname,'.mat'],'final_res');


end
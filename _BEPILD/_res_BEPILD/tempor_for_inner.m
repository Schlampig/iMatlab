function tempor_for_inner()

name =  {'All_res_BEK1PILD.mat';
'All_res_K1PILD.mat';
'All_res_BEK2PILD.mat';
'All_res_BEK3PILD.mat';
'All_res_K3PILD.mat';
'All_res_BESVML.mat';
'All_res_BEFLD.mat';
'All_res_FLD.mat';
'All_res_BERL.mat'};

    AUC = [];
    AUCstd = [];
    for i = 1:9
        load(name{i,1});  
        [r,c] = size(Res_AUC);
        if c == 10 %有greed方法，变量很多
            c_index = 5;
            [res1, resstd1] = find_max(Res_AUC(:,1:c_index),Res_AUCstd(:,1:c_index));
            [res2, resstd2] = find_max(Res_AUC(:,c_index+1:end),Res_AUCstd(:,c_index+1:end));        
            AUC_final = [res1,res2];
            AUCstd_final = [resstd1,resstd2];
            clear res1; clear resstd1;clear res2;clear resstd2;
        elseif c == 2 %有greed方法，无变量
            AUC_final = [Res_AUC(:,1),Res_AUC(:,2)];
            AUCstd_final = [Res_AUCstd(:,1),Res_AUCstd(:,2)];
        else %无greed
            [AUC_final, AUCstd_final] = find_max(Res_AUC, Res_AUCstd);
        end %if
        AUC = [AUC,AUC_final];
        AUCstd = [AUCstd,AUCstd_final];        
        clear AUC_final;clear AUCstd_final;
        disp(name{i,1});
    end%for_i
%     save('inner_compare.mat','AUC','AUCstd');
    f = fopen('inner_compare.txt', 'w');
    for n = 1:r
        fprintf(f,'%.2f  ',AUC(n,:));
        fprintf(f,'\n');
        fprintf(f,'%.2f  ',AUCstd(n,:));
        fprintf(f,'\n');
    end%for_n
    fclose(f);
    
    
end%tempor_for_inner

function [vec_auc, vec_std] = find_max(mat_auc,mat_std)
    [vec_auc, index] = max(mat_auc,[],2);
    vec_std = [];  
    for k = 1:size(mat_std,1)
        vec_std = [vec_std;mat_std(k,index(k))];
    end%for_k    
end%find_max




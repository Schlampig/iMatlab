%调用各种LPP算法的总方法

rdim = [81;144;256;576];
k = 5;
a = 2;

for i_dim = 1:length(rdim)
    Rdim = rdim(i_dim);
    for i_data = 1:6
        switch i_data%根据数据集标号选择数据集  
            case 1
                dataname = 'Coil20';
                dataname_index = 1;
            case 2
                dataname = 'ORL';
                dataname_index = 1;
            case 3
                dataname = 'PIE_mini';
                dataname_index = 1;
            case 4
                dataname = 'Yale';
                dataname_index = 1;
            case 5
                dataname = 'YaleB';
                dataname_index = 1;
            case 6
                dataname = 'COIL100_mini';
                dataname_index = 0;
            otherwise
                disp('You have input wrong dataset number!');%报错 
        end%end_switch_dataset_kind  
    
        for i_alg = 1:7
            fNew(a,k,Rdim,dataname,dataname_index,i_alg);
        end%i_alg
        
    end%for_i_data
end%for_i_dim


